//
//  ChannelLabel.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/2.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "ChannelLabel.h"
#import "CZAdditions.h"
@implementation ChannelLabel
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor cz_randomColor];
    }
    return self;
}


@end
