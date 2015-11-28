//
//  DetailViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

-(void)viewDidLoad{
  //  self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSURL *url = [NSURL URLWithString:self.newsModel.url_3w];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}
@end
