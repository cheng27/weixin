//
//  AddressViewController.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "AddressViewController.h"
#import "QYFriendGroup.h"
#import "FriendsTableViewCell.h"
#import "SectionHeaderView.h"
#import "ResultsTableViewController.h"

@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
@property (nonatomic,strong) NSMutableArray *friends;
@property (nonatomic,strong) NSArray *results;
@property (nonatomic,strong) NSMutableDictionary *dict;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) UISearchController *searchControl;


@end

@implementation AddressViewController
static NSString *identifier = @"cell";
- (NSArray *)friends
{
    if (_friends == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            QYFriendGroup *friendGroup = [QYFriendGroup friendGroupWithDict:dict];
            [models addObject:friendGroup];
        }
        _friends = models;
    }
    return _friends;
}

- (IBAction)editClickAction:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"完成";
        [_tableView setEditing:YES];
    }else
    {
        sender.title = @"编辑";
        [_tableView setEditing:NO];
    }
}
- (IBAction)searchAction:(id)sender {
    [self presentViewController:_searchControl animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.sectionHeaderHeight = 50;
    _tableView.rowHeight = 50;
    
    
    //创建结果视图控制器
    ResultsTableViewController *result = [[ResultsTableViewController alloc] init];
    //设置结果控制器中的数据
    result.datas = self.friends;
    
    _searchControl = [[UISearchController alloc] initWithSearchResultsController:result];
    _searchControl.searchBar.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 44);
    self.tableView.tableHeaderView = _searchControl.searchBar;
    //设置代理
    _searchControl.searchResultsUpdater = result;
    //设置导航栏隐藏
    _searchControl.hidesNavigationBarDuringPresentation = YES;
    _searchControl.dimsBackgroundDuringPresentation = NO;
}

#pragma mark - UITableViewDataSource
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.friends.count;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    QYFriendGroup *friendGroup = self.friends[section];
    if (friendGroup.isOpen) {
        return friendGroup.friends.count;
    }
    return 0;
}
//单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    QYFriendGroup *friendGroup = self.friends[indexPath.section];
    QYFriend *friend = friendGroup.friends[indexPath.row];
    cell.friends = friend;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建自定义的section的头视图
    SectionHeaderView *headerView = [SectionHeaderView sectionHeaderViewForTableView:tableView];
    QYFriendGroup *friendGroup = self.friends[section];
    headerView.friendGroup = friendGroup;
    headerView.headerViewClick = ^{
        [tableView reloadData];
    };
    return headerView;
}
#pragma mark - UISearchResultUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if ([searchController.searchBar.text isEqualToString:@""]) {
        _results = self.friends;
        [self.tableView reloadData];
        return;
    }
    //创建过滤谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[CD] %@",searchController.searchBar.text];
    //过滤数据
    _results = [_friends filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#pragma mark - 编辑--1.添加删除 2.移动 3.扩展
//添加
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//设置当前单元格的编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
}

//❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //取出当前数据
//    QYFriendGroup *friendGroup = self.friends[indexPath.section];
//    NSMutableArray *array = friendGroup.friends;
//    
//    if (editingStyle == UITableViewCellEditingStyleInsert) {
//    
//    }else if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        //更改数据源
//        [array removeObjectAtIndex:indexPath.row];
//        //更改界面
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}
//❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀❀


//移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 1.取出源单元格对应的数据
    //取源section对应的sourceKey
    QYFriendGroup *sourceFriendGroup = self.friends[sourceIndexPath.section];
    
    //用sourceKey取section的所有数据sourceArray
    NSMutableArray *sourceArray = sourceFriendGroup.friends;
    //从sourceArray中取到当前单元格的内容
    NSDictionary *sourceDict = sourceArray[sourceIndexPath.row];
    
    //把移动的单元格内容移除
    [sourceArray removeObjectAtIndex:sourceIndexPath.row];
    
    // 2.把取到的源单元格的数据插入到目的indexPath
    //取到插入的数据
    QYFriendGroup *destGroup = self.friends[destinationIndexPath.section];
    NSMutableArray *destArray = destGroup.friends;
    [destArray insertObject:sourceDict atIndex:destinationIndexPath.row];
}
//扩展
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"分享" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"微信" otherButtonTitles:@"QQ", nil];
        [actionSheet showInView:actionSheet];
        
    }];
    rowAction.backgroundColor = [UIColor cyanColor];
    
    UITableViewRowAction *rowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //取出当前数据
        QYFriendGroup *friendGroup = self.friends[indexPath.section];
        NSMutableArray *array = friendGroup.friends;
        //更改数据源
        [array removeObjectAtIndex:indexPath.row];
        //更改界面
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }];
    rowAction2.backgroundColor = [UIColor blueColor];
    return @[rowAction,rowAction2];
}


@end
