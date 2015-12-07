//
//  ResultTableViewController.h
//  微信
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewController : UITableViewController<UISearchResultsUpdating>
//将要搜索的数据
@property (nonatomic,strong) NSArray *datas;

@end
