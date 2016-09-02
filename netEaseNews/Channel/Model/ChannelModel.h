//
//  ChannelModel.h
//  netEaseNews
//
//  Created by zhangyu on 16/9/2.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject
@property(copy,nonatomic)NSString *tname;
@property(copy,nonatomic)NSString *tid;

+(NSArray *)GetChannel;
@end
