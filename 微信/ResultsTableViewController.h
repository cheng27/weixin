//
//  ResultsTableViewController.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController<UISearchResultsUpdating>

@property (nonatomic,strong) NSArray *datas;

@end
