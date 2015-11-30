//
//  NewsTableViewCell.m
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell()
/**
 *  第一张图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *ImgIcon;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;
/**
 *  第二张图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageSecond;
/**
 *  第三张图片
 */

@property (weak, nonatomic) IBOutlet UIImageView *imageThird;

@end

@implementation NewsTableViewCell
/**
 *  返回不同的cell类型
 *
 */
+(NSString *)idForRow:(NewsModel *)newsModel index:(NSInteger)index;
{
#if 0
    if ( newsModel.hasHead &&newsModel.photosetID) {
        return @"TopImageCell";
    }else if (newsModel.hasHead){
        return @"TopTxtCell";
    }else if (newsModel.imgType){
        return @"BigImageCell";
    }else if (newsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
#else
    if (newsModel.hasHead &&(newsModel.ads!= nil)&&index == 0) {
        return @"PageCell";
    }
    else if ( newsModel.hasHead &&newsModel.photosetID) {
        return @"TopImageCell";
    }else if (newsModel.hasHead){
        return @"TopTxtCell";
    }else if (newsModel.imgType){
        return @"BigImageCell";
    }else if (newsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
#endif
}
/**
 *  类方法返回行高
 */
+ (CGFloat)heightForRow:(NewsModel *)newsModel
{
    if (newsModel.hasHead && newsModel.photosetID){
        return 245;
    }else if(newsModel.hasHead) {
        return 245;
    }else if(newsModel.imgType) {
        return 170;
    }else if (newsModel.imgextra){
        return 130;
    }else{
        return 80;
    }
}
/**
 *  重写set方法,设置cell中得各个属性
 */
-(void)setNewsModel:(NewsModel *)newsModel{
    _newsModel = newsModel;
    [self.ImgIcon sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgsrc]];
    self.labelTitle.text = _newsModel.title;
    self.labelSubTitle.text = _newsModel.digest;
    if (_newsModel.imgextra.count == 2) {
        [self.imageSecond sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgextra[0][@"imgsrc"]]];
        [self.imageThird sd_setImageWithURL:[NSURL URLWithString:_newsModel.imgextra[1][@"imgsrc"]]];
    }
}
@end
