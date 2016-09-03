//
//  HomeViewController.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/2.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "ChannelLabel.h"
#import "CZAdditions.h"
#import "HomeCollectionViewCell.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(weak,nonatomic)IBOutlet UIScrollView *channelScrollView;
//newsCollectionView
@property(weak,nonatomic)IBOutlet UICollectionView *newsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *FlowLayout;



@property(strong,nonatomic)NSArray *channelArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createChannelLabel];
}
//设置CellSize
-(void)viewDidAppear:(BOOL)animated{
    //********
    [super viewDidAppear:animated];
    self.FlowLayout.itemSize = self.newsCollectionView.bounds.size;
}
// 创建频道标签和展示标签数据
-(void)createChannelLabel{
    self.channelArr = [ChannelModel GetChannel];
    CGFloat labelW = 80;
    CGFloat labelH = self.channelScrollView.bounds.size.height;
    for (int i = 0; i < self.channelArr.count; i++) {
        ChannelLabel *label = [[ChannelLabel alloc]init];
        [self.channelScrollView addSubview:label];
        
        CGFloat labelX = labelW * i;
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        
        self.channelScrollView.contentSize = CGSizeMake(labelW * self.channelArr.count, 0);
        
        ChannelModel *model = self.channelArr[i];
        label.text = model.tname;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTapClick:)];
        [label addGestureRecognizer:tap];
        label.tag = i;
        label.userInteractionEnabled = YES;
    };
}
-(void)labelTapClick :(UITapGestureRecognizer *)tap{
    ChannelLabel *label = (ChannelLabel *)tap.view;
    CGFloat labelOffsetX = label.center.x - (self.view.bounds.size.width * 0.5);
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = 0;
    }else if (labelOffsetX > maxOffsetX){
        labelOffsetX = maxOffsetX;
    }
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:label.tag inSection:0];
    [self.newsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
}
//频道标签的点击事件
//实现UICollectionViewDataSource方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelArr.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    ChannelModel *model = self.channelArr[indexPath.item];
    NSString *URLString = [NSString stringWithFormat:@"article/headline/%@/0-20.html",model.tid];
    cell.URLString = URLString;
//    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
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
