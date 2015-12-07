//
//  ViewController.m
//  微信
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYTGViewController.h"
#import "QYtgModel.h"
#import "QYTableViewCell.h"
#import "ResultTableViewController.h"

@interface QYTGViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) UISearchController *searchController;

@end

@implementation QYTGViewController

- (NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYtgModel *model = [QYtgModel tgWithDict:dict];
            [models addObject:model];
        }
        _datas = models;
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建barBtnItem
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editAction:)];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    //创建结果视图控制器
    ResultTableViewController *result = [[ResultTableViewController alloc] init];
    //设置结果控制器中的数据
    result.datas = self.datas;
    _searchController = [[UISearchController alloc] initWithSearchResultsController:result];
    //设置代理
    _searchController.searchResultsUpdater = result;
    //设置导航栏隐藏
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    [self createScrollView];
    [self createRefreshControl];
    
}
- (IBAction)searchItemClick:(UIBarButtonItem *)sender {
    [self presentViewController:_searchController animated:YES completion:nil];
}

- (void)createScrollView
{
    _ScrollView.delegate = self;
    _ScrollView.contentSize = CGSizeMake(3*375, 667);
    _ScrollView.pagingEnabled = YES;
}


- (void)editAction:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        [_tableView setEditing:YES];
    }else
    {
        item.title = @"编辑";
        [_tableView setEditing:NO];
    }
}
#pragma mark - 1.下拉刷新  2.上拉加载更多
//下拉刷新
- (void)createRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [_tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}
- (void)refresh:(UIRefreshControl *)refreshControl
{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:5];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    QYTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    QYtgModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}
#pragma mark - 编辑--1.删除 2.移动 3.扩展
//编辑--删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //更改数据源
    [self.datas removeObjectAtIndex:indexPath.row];
    //更改界面
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //取出源单元格对应的数据
    //取源section对应的所有数据
    //NSMutableArray *sourceArray = self.datas;
    NSString *sourceStr = self.datas[sourceIndexPath.row];
    //把移动的单元格内容移除
    [self.datas removeObjectAtIndex:sourceIndexPath.row];
    //把取到的源单元格的数据插入到目的indexpath
    //取到插入的数据
    //NSMutableArray *destArray = self.datas[destinationIndexPath.row];
    [self.datas insertObject:sourceStr atIndex:destinationIndexPath.row];
}

#pragma mark - 扩展
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"微博" otherButtonTitles:@"QQ", nil];
        [actionSheet showInView:actionSheet];
        
    }];
    rowAction.backgroundColor = [UIColor cyanColor];
    
    UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //更改数据源
        [self.datas removeObjectAtIndex:indexPath.row];
        //更改界面
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];    }];
    rowAction2.backgroundColor = [UIColor lightGrayColor];
    
    return @[rowAction,rowAction2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
