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
@implementation HomeCollectionViewCell
-(void)awakeFromNib{
    UIStoryboard *newsStoryboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    NewsTableViewController *newsVC = [newsStoryboard instantiateInitialViewController];
    [self.contentView addSubview:newsVC.tableView];
    
    newsVC.tableView.frame = self.contentView.bounds;
    newsVC.tableView.backgroundColor = [UIColor cz_randomColor];
}
@end
