//
//  HomeCollectionViewCell.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"
#import "CZAdditions.h"
@interface HomeCollectionViewCell()

@property(strong,nonatomic)NewsTableViewController *newsVC;

@end
@implementation HomeCollectionViewCell
-(void)awakeFromNib{
    UIStoryboard *newsStoryboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    self.newsVC = [newsStoryboard instantiateInitialViewController];
    [self.contentView addSubview:self.newsVC.tableView];
    
    self.newsVC.tableView.frame = self.contentView.bounds;
    self.newsVC.tableView.backgroundColor = [UIColor cz_randomColor];
}
-(void)setURLString:(NSString *)URLString{
    _URLString = URLString;
    self.newsVC.URLString = URLString;
}
@end
