//
//  PageCell.h
//  NewsClient
//
//  Created by 大龙 on 15/11/28.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface PageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) NewsModel *newsModel;

-(void)setPropertyOfCell:(NewsModel *)model
                  Number:(NSInteger)number;
@end
