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

// 频道标签数组
NSMutableArray *_channelLabelsM;
- (void)viewDidLoad {
    [super viewDidLoad];
    _channelLabelsM = [NSMutableArray array];
//    self.navigationController.navigationBar.layer.contents = (id)[UIImage imageWithColor:[UIColor colorWithRed:208/255.0 green:23/255.0 blue:30/255.0 alpha:1.0]].CGImage;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:208/255.0 green:23/255.0 blue:30/255.0 alpha:1.0]];
    self.navigationController.navigationBar.translucent = NO;
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
        [_channelLabelsM addObject:label];
        if (i == 0) {
            label.scale = 1.0;
        }
    }
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
    
    
    
    // 获取选中的标签的索引
    NSInteger index = label.tag;
    
    // 需要把选中的标签设置最大的缩放比,非选中的还原
    for (NSInteger i = 0; i < self.channelArr.count; i++) {
        
        ChannelLabel *label = _channelLabelsM[i];
        
        if (index == i) {
            label.scale = 1.0;
        } else {
            label.scale = 0.0;
        }
    }
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 计算当前滚动到第几个item (索引)
    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    // 拿着索引去标签数组找对应的标签
    ChannelLabel *label = _channelLabelsM[index];
    
    // 计算选中的label剧中时,要滚动的偏移量
    CGFloat labelOffsetX = label.center.x - (self.view.bounds.size.width * 0.5);
    
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.channelScrollView.contentSize.width - self.view.bounds.size.width;
    // 判断偏移量的临界值
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = 0;
    } else if (labelOffsetX > maxOffsetX) {
        labelOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.channelScrollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat W = self.view.bounds.size.width;
    
    // 获取浮点数的索引
    CGFloat index_float = offsetX / W;
    
    // 整数整型索引
    NSInteger index = offsetX / W;
    
    // 浮点数的索引 减 整型的索引 = 百分比
    CGFloat percent = index_float - index;
    //    NSLog(@"浮点数索引=%f 整型索引=%zd 百分比=%f",index_float,index,percent);
    
    // 要实现左右滚动的缩放,需要确定四个值 : 左边的索引,右边的索引,左边的缩放比,右边的缩放比
    
    // 左边的索引,就是当前的索引
    NSInteger left_index = index;
    // 右边的索引,就是左边的索引加1
    NSInteger right_index = left_index + 1;
    
    // 右边的缩放比
    CGFloat right_scale = percent;
    // 左边的缩放比
    CGFloat left_scale = 1 - right_scale;
    
    //NSLog(@"左边索引=%zd 左边缩放比=%f 右边=索引%zd 右边缩放比=%f",left_index,left_scale,right_index,right_scale);
    
    // 取出左边索引对应的标签,设置对应的缩放比
    ChannelLabel *left_label = _channelLabelsM[left_index];
    left_label.scale = left_scale;
    // 取出右边索引对应的标签,设置对应的缩放比
    if (right_index < _channelLabelsM.count) {
        ChannelLabel *right_Label = _channelLabelsM[right_index];
        right_Label.scale = right_scale;
    }
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
