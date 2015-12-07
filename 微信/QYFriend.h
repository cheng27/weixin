//
//  QYAddressModel.h
//  微信
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYFriend : NSObject
//声明属性
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *status;
@property (nonatomic) BOOL vip;
//声明初始化方法
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendsWithDict:(NSDictionary *)dict;

@end
