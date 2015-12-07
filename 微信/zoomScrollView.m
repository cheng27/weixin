//
//  zoomScrollView.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "zoomScrollView.h"
@interface zoomScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imgView;
@end

@implementation zoomScrollView
- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        _imgView = imageView;
        //设置自身属性
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 0.5;
        self.delegate = self;
        //添加双击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        //设置有效点击次数
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)doubleClick:(UITapGestureRecognizer *)tap
{
    //当前缩放比例不为1的时候，重置为1
    if (self.zoomScale != 1) {
        self.zoomScale = 1;
        return;
    }
    //当前缩放比例为1的时候，放大到一个指定的矩形区域
    CGPoint point = [tap locationInView:self];
    CGRect rect = CGRectMake(point.x - 100, point.y - 100, 200,200);
    [self zoomToRect:rect animated:YES];
}

- (void)setImage:(UIImage *)image
{
    _imgView.image = image;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}
@end
