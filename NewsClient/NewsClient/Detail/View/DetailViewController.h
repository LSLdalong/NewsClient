//
//  DetailViewController.h
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface DetailViewController : UIViewController
@property (nonatomic,strong)NewsModel *newsModel;


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
