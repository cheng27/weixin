//
//  SectionHeaderView.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYFriendGroup;

@interface SectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong) QYFriendGroup *friendGroup;
@property (nonatomic,strong) void (^headerViewClick) (void);

+ (instancetype) sectionHeaderViewForTableView:(UITableView *)tableView;

@end
