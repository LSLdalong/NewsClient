//
//  NewsTableViewCell.h
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) NewsModel *newsModel;
//返回不同的cell
+(NSString *)idForRow:(NewsModel *)newsModel;
//返回不同的行高
+ (CGFloat)heightForRow:(NewsModel *)newsModel;

@end
