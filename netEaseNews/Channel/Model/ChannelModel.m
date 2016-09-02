//
//  ChannelModel.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/2.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

+(instancetype)channelModelWithDict:(NSDictionary *)Dict{
    ChannelModel *model = [[ChannelModel alloc]init];
    [model setValuesForKeysWithDictionary:Dict];
    return model;
}
+(NSArray *)GetChannel{
    //get jsonpath
    NSString *JSONPath = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *JSONData = [NSData dataWithContentsOfFile:JSONPath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:NULL];
    NSArray *tList = rootDict[@"tList"];
    NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:tList.count];
    [tList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelModel *model = [ChannelModel channelModelWithDict:obj];
        [tmpM addObject:model];
    }];
    [tmpM sortUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel *obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return tmpM.copy;
};

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@--%@",self.tname,self.tid];
}
@end
