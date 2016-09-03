//
//  NewsModel.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "NewsModel.h"
#import "NetworkTool.h"
@implementation NewsModel
+(instancetype)newsModelWithDict:(NSDictionary *)dict{
    NewsModel *model = [[NewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@",self.title,self.source];
}
+(void)loadNewWithURLString:(NSString *)URLString successBlock:(void(^)(NSArray *newsList))successBlock failedBlock:(void(^)(NSError *error))failedBlock{
    [[NetworkTool sharedNetworkTool]GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *dictArr = responseObject[key];
        NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        [dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [NewsModel newsModelWithDict:obj];
            [tmpM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(tmpM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
@end
