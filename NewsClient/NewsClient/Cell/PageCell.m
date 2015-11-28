//
//  PageCell.m
//  NewsClient
//
//  Created by 大龙 on 15/11/28.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "PageCell.h"
#import "AdsModel.h"
@implementation PageCell
-(void)setPropertyOfCell:(NewsModel *)model
                  Number:(NSInteger)number{
    self.scroll.contentSize =CGSizeMake(self.scroll.frame.size.width * (number+1+2), 0);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scroll.frame.size.width, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    AdsModel *lastModel =model.ads.lastObject;
    self.label.text = lastModel.title;
    [self.scroll addSubview:imageView];
    
    for (int i = 0; i < number ; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scroll.frame.size.width *(i+2), 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
        AdsModel *adsModel = model.ads[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:adsModel.imgsrc]];
        [self.scroll addSubview:imageView];
    }
    /**
     *  添加首尾两张图片
     */
    UIImageView *imageFistView = [[UIImageView alloc] initWithFrame:self.scroll.frame];
    AdsModel *firstModel = model.ads[model.ads.count-1];
    [imageFistView sd_setImageWithURL:[NSURL URLWithString:firstModel.imgsrc]];
    [self.scroll addSubview:imageFistView];
    
    UIImageView *imageLastView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scroll.frame.size.width * (number + 2), 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
    [imageLastView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    [self.scroll addSubview:imageLastView];
    
    
    
    
    self.scroll.contentOffset = CGPointMake(self.scroll.frame.size.width, 0);
    self.scroll.pagingEnabled = YES;
}

-(void)setPageControlOfCell{
    
    
}

//-(void)setNewsModel:(NewsModel *)newsModel{
//    _newsModel = newsModel;
//    UIImageView *imageFirst =  self.scrollView.subviews[0];
//    [imageFirst sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgsrc]];
//    for (int i = 0 ; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
//    
//    
//}
@end
