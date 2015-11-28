//
//  NewsTableViewController.h
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController
/**
 *  url
 */
@property (nonatomic,strong) NSString *urlString;
/**
 *  标题
 */
@property (nonatomic,strong) NSString *headline;
@end
