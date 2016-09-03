//
//  NetworkTool.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool
//单例实例化方法的实现
+(instancetype)sharedNetworkTool{
    static NetworkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[NetworkTool alloc]initWithBaseURL:baseURL];
    });
    return instance;
}
@end
