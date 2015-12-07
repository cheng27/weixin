//
//  SettingViewController.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "SettingViewController.h"
#import "zoomScrollView.h"

@interface SettingViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation SettingViewController

- (void)createScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 400, 667)];
    [self.view addSubview:_scrollView];
    //设置内容大小
    _scrollView.contentSize = CGSizeMake(400*5, 667);
    //设置分页
    _scrollView.pagingEnabled = YES;
    //设置不显示滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _scrollView.delegate = self;
    //设置背景颜色
    _scrollView.backgroundColor = [UIColor blackColor];
}

- (void)addSubViews
{
    for (int i = 0; i < 5; i++) {
        zoomScrollView *ScrollView = [[zoomScrollView alloc] initWithFrame:CGRectMake(400*i,0, 375, 667)];
        [_scrollView addSubview:ScrollView];
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i+1];
        //通过方法设置
        [ScrollView setImage:[UIImage imageNamed:imgName]];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (id scroll in scrollView.subviews) {
        // 判断scroll对象是否是zoomScrollView类型的
        if ([scroll isKindOfClass:[zoomScrollView class]]) {
            zoomScrollView *zoom = scroll;
            //设置缩放比例
            zoom.zoomScale = 1;
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
    [self addSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
