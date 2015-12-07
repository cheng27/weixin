//
//  QYFriendGroup.m
//  微信
//
//  Created by qingyun on 15/12/6.
//  Copyright (c) 2015年 阿六. All rights reserved.
//

#import "QYFriendGroup.h"
#import "QYFriend.h"

@implementation QYFriendGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *array = [NSMutableArray array];
        //遍历friends，把字典转化成模型
        for (NSDictionary *dic in self.friends) {
            QYFriend *friend = [QYFriend friendsWithDict:dic];
            [array addObject:friend];
        }
        self.friends = array;
        //self.isOpen = YES;
    }
    return self;
}

+ (instancetype)friendGroupWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}

@end
