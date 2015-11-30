//
//  PhotoViewController.h
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface PhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *num;
/**
 *  photoID
 */
@property (nonatomic,strong) NSString *photoSetID;
/**
 *  给titleName传值的name
 */
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NewsModel *newsModel;
@end
