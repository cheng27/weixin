//
//  SectionHeaderView.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "SectionHeaderView.h"
#import "QYFriendGroup.h"
@interface SectionHeaderView()
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) UILabel *label;
@end

@implementation SectionHeaderView

static NSString *headerViewIdentifier = @"headerView";

+ (instancetype)sectionHeaderViewForTableView:(UITableView *)tableView
{
    SectionHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:headerViewIdentifier];
    if (headerView == nil) {
        headerView = [[SectionHeaderView alloc] initWithReuseIdentifier:headerViewIdentifier
        ];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //添加背景btn
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_btn];
        //设置背景
        UIImage *img = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 0, 44, 1) resizingMode:UIImageResizingModeStretch];
        [_btn setBackgroundImage:img forState:UIControlStateNormal];
        UIImage *highlightedImg = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        [_btn setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
        //设置图标
        [_btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        //设置标题的字体颜色
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置内容的显示
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //设置设置整体的偏移量
        _btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置标题的偏移量
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置btn图片视图的内容模式
        _btn.imageView.contentMode = UIViewContentModeCenter;
        _btn.imageView.clipsToBounds = NO;
        //添加事件监听
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加label（在线人数/总人数）
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
        _label.textAlignment = NSTextAlignmentRight ;
    }
    return self;
}

- (void) btnClick:(UIButton *)btn
{
    _friendGroup.isOpen = !_friendGroup.isOpen;
    if (_headerViewClick) {
        _headerViewClick();
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置btn的frame
    _btn.frame = self.bounds;
    //设置label的frame
    CGFloat labelW = 100;
    CGFloat labelH = self.bounds.size.height;
    CGFloat labelX = self.bounds.size.width - labelW - 10;
    CGFloat labelY = 0;
    _label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

- (void)setFriendGroup:(QYFriendGroup *)friendGroup
{
    _friendGroup = friendGroup;
    //设置btn的标题
    [_btn setTitle:friendGroup.name forState:UIControlStateNormal];
    _label.text = [NSString stringWithFormat:@"%ld/%ld",friendGroup.online,friendGroup.friends.count];
    
    if (_friendGroup.isOpen) {
        _btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else
    {
        _btn.imageView.transform = CGAffineTransformIdentity;
    }
}

@end
