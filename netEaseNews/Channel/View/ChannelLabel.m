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
//        self.backgroundColor = [UIColor cz_randomColor];
    }
    return self;
}
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // 字体颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    // 限制最大和最小的缩放比
    CGFloat minScale = 1.0;
    CGFloat maxScale = 1.2;
    
    //  scale = 1.0 + (0.2) * scale
    
    scale = minScale + (maxScale - minScale) *scale;
    
    // 控件大小缩放
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

@end
