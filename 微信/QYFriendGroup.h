//
//  QYFriendGroup.h
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriendGroup : NSObject
//声明属性
@property (nonatomic,strong) NSMutableArray *friends;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) NSInteger online;
@property (nonatomic) BOOL isOpen;
//声明初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendGroupWithDict:(NSDictionary *)dict;

@end
