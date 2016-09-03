//
//  NewsModel.h
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *imgsrc;
@property(copy,nonatomic)NSString *source;
@property(copy,nonatomic)NSString *replyCount;

+(void)loadNewWithURLString:(NSString *)URLString successBlock:(void(^)(NSArray *newsList))successBlock failedBlock:(void(^)(NSError *error))failedBlock;


@end
