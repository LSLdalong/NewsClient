//
//  TopScrollView.h
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^buttontype)(NSInteger index);
/**
 *  位于头部的滑动视图，按钮导航。
 头条、NBA、娱乐、时尚、汽车、房产、段子   我目前先只做七个
 */
@interface TopScrollView : UIScrollView
@property (nonatomic,copy)buttontype buttonJump;
@end
