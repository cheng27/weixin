//
//  QYTableViewCell.m
//  微信
//
//  Created by qingyun on 15/12/4.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYtgModel.h"

@implementation QYTableViewCell

- (void)setModel:(QYtgModel *)model
{
    _model = model;
    _imgView.image = [UIImage imageNamed:model.icon];
    _titleLabel.text = model.title;
    _priceLabel.text = model.price;
    _buyCountLabel.text = model.buycount;
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick:(UIButton *)btn
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.hao123.com/"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
