//
//  NewsTableViewCell.h
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
// 接收新闻VC传入的新闻模型
@property (nonatomic,strong)NewsModel *news;
@end
