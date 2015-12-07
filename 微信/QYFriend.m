//
//  QYAddressModel.m
//  微信
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYFriend.h"

@implementation QYFriend

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendsWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
