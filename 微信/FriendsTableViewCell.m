//
//  FriendsTableViewCell.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "FriendsTableViewCell.h"
#import "QYFriend.h"

@implementation FriendsTableViewCell

- (void)setFriends:(QYFriend *)friends
{
    _friends = friends;
    self.textLabel.text = friends.name;
    self.detailTextLabel.text = friends.status;
    self.imageView.image = [UIImage imageNamed:friends.icon];
    self.textLabel.textColor = friends.vip ? [UIColor redColor] : [UIColor blackColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
