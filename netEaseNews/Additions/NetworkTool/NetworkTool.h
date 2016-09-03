//
//  NetworkTool.h
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkTool : AFHTTPSessionManager
+(instancetype)sharedNetworkTool;
@end
