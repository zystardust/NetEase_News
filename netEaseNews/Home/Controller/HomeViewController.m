//
//  HomeViewController.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/2.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *channelArr = [ChannelModel GetChannel];
    NSLog(@"%@",channelArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
