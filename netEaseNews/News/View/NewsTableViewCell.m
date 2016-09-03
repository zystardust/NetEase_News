//
//  NewsTableViewCell.m
//  netEaseNews
//
//  Created by zhangyu on 16/9/3.
//  Copyright © 2016年 zhangyu. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface NewsTableViewCell  ()
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *replaycountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;
@end
@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setNews:(NewsModel *)news{
    _news = news;
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.titleLabel.text = news.title;
    self.sourceLabel.text = news.source;
    
    NSString *replycount;
    if (news.replyCount == nil) {
        replycount = @"0";
    }else{
        replycount = [NSString stringWithFormat:@"%@",news.replyCount];
    }
    self.replaycountLabel.text = replycount;
    for (int i = 0; i < _imgsrcImageViews.count; i++) {
        UIImageView *img = self.imgsrcImageViews[ i ];
        NSDictionary *imgsrcDict = news.imgextra[ i ];
        NSString *imgsrc = imgsrcDict[@"imgsrc"];
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
