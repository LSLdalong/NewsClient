//
//  ViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/25.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "ViewController.h"
#import "NewsTableViewController.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet TopScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addController];
    
    self.bigScrollView.contentSize = CGSizeMake(self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width, 0);
    
    self.bigScrollView.pagingEnabled = YES;
    //添加第一个tableView
    
    UIViewController *VC = [self.childViewControllers firstObject];
    VC.view.frame = self.bigScrollView.bounds;
    self.automaticallyAdjustsScrollViewInsets = NO;
    


    NSLog(@"%f,%f",self.bigScrollView.bounds.origin.x,self.bigScrollView.bounds.origin.y);
    [self.bigScrollView addSubview:VC.view];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
/**
 *  添加子控制器
 */
-(void)addController{
    for (int i = 0; i < 8; i++) {
        NewsTableViewController *NewsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"News"];
        [self addChildViewController:NewsVC];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
