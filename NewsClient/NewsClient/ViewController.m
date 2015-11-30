//
//  ViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/25.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "ViewController.h"
#import "NewsTableViewController.h"
#import <MJRefresh.h>
#import "WeatherViewController.h"
#define  dalong 1
@interface ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet TopScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (nonatomic,strong) WeatherViewController *weatherVC;
@property (nonatomic,assign)BOOL weatherShow;
/**
 *  如果加载过就设置为1
 */
@property (nonatomic,assign)BOOL viewSucess;
/**
 *  从plist文件中获取的数组
 */
@property (nonatomic,strong) NSMutableArray *newsList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButtons];
    [self addController];
    self.bigScrollView.delegate = self;
    self.bigScrollView.contentSize = CGSizeMake(self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width, 0);
  //  self.bigScrollView.contentSize = CGSizeMake(0, 0);

    
    self.bigScrollView.pagingEnabled = YES;
    //添加第一个tableView
    UIViewController *VC = [self.childViewControllers firstObject];
    VC.view.frame = self.bigScrollView.bounds;
    self.automaticallyAdjustsScrollViewInsets = NO;
    /**
     *  把scroll 的scrollsToTop设置为no
     */
    self.topScrollView.scrollsToTop = NO;
    self.bigScrollView.scrollsToTop = NO;



    [self.bigScrollView addSubview:VC.view];
    
    __weak typeof(self) weakSelf = self;
    self.topScrollView.buttonJump = ^(NSInteger index){
        NSLog(@"%ld",index);
        [weakSelf changetopScrollViews:index];
        [weakSelf changebigScrollViews:index];
        [weakSelf changeFont:index];
        for (int i = 200; i < 208; i++) {
            UIButton *button = [weakSelf.topScrollView viewWithTag:i ];
            if (i == (200 + index)) {
                button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
            else
            {
               button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
        
        CGPoint point = CGPointMake(index * self.bigScrollView.bounds.size.width, 0);
        self.bigScrollView.contentOffset = point;
        [self setTopToYes:index];
    };
    
    
    // Do any additional setup after loading the view, typically from a nib.

}
/**
 *  懒加载weatherVC
 *
 */
-(WeatherViewController *)weatherVC{
    if (_weatherVC == nil) {
        _weatherVC = [self.storyboard instantiateViewControllerWithIdentifier:@"weather"];
        _weatherVC.view.alpha = 0.8;
        [self.view addSubview:_weatherVC.view];
        _weatherVC.view.hidden = YES;
        self.weatherShow = NO;
        
    }
    return _weatherVC;
}

/**
 *  懒加载weatherShow
 */


/**
 *  设置tabbar的Button
 *
 *  @return NO
 */
-(void)setButtons{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navigation_square"] style:UIBarButtonItemStyleDone target:self action:@selector(pushToWeather)];
    [rightButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
}
/**
 *  跳转到天气界面
 *
 *  @return NO
 */
-(void)pushToWeather{
    if (self.weatherShow) {
        self.weatherVC.view.hidden = YES;
        self.weatherShow = NO;
        
    }
    else{
        self.weatherVC.view.hidden = NO;
        self.weatherShow = YES;
        
    }
    
    
}

/**
 *  改变标题颜色和字体
 */
-(void)changeFont:(NSInteger)index{
    for (int i = 200; i < 208; i++) {
        UIButton *button = [self.topScrollView viewWithTag:i ];
        if (i == (200 + index)) {
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else
        {
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }

   }
}
/**
 *  改变topScorll坐标,显示不同的位置
 */
-(void)changetopScrollViews:(NSInteger)index{
    if(index >= 2&&index <=5){
        CGPoint point =CGPointMake(LABELWIDTH * (index-2), 0);
        NSLog(@"%f,,,,,,%f",point.x,point.y);
       // self.topScrollView.contentOffset = point;
        [self.topScrollView setContentOffset:point animated:YES];
    }
    
}
/**
 *  改变bigscorll坐标,显示不同的tableView
 */
-(void)changebigScrollViews:(NSInteger)index{
            CGPoint point = CGPointMake(index * self.bigScrollView.bounds.size.width, 0);
            self.bigScrollView.contentOffset = point;
    NewsTableViewController *newsTVC = self.childViewControllers[index];
    newsTVC.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:newsTVC.view];
}
/**
 *  添加子控制器
 */
-(void)addController{
    for (int i = 0; i < 8; i++) {
        NewsTableViewController *NewsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"News"];
        NewsVC.headline = self.newsList[i][@"title"];
        NewsVC.urlString = self.newsList[i][@"urlString"];
        [self addChildViewController:NewsVC];
    }
}

/**
 *  懒加载newsList
 */
-(NSMutableArray *)newsList{
    if (_newsList == nil) {
        _newsList = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _newsList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----Scroll代理方法 ----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x/self.bigScrollView.frame.size.width;
    /**
     *  改变topScroll控制器的位置
     */
    [self changetopScrollViews:index];
    [self changeFont:index];
    [self setTopToYes:index];
    NewsTableViewController *newsTVC = self.childViewControllers[index];
    newsTVC.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:newsTVC.view];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    for (NewsTableViewController *VC in self.childViewControllers) {
       // VC.tableView.scrollsToTop = NO;
        VC.tableView.hidden = NO;
    }
}

/**
 *  把当前tableview 的ScrolltoTop设置为yes
 */
-(void)setTopToYes:(NSInteger) index
{
    for (NewsTableViewController *VC in self.childViewControllers) {
        VC.tableView.scrollsToTop = NO;
        VC.tableView.hidden = YES;
    }
    NewsTableViewController *VC1 = self.childViewControllers[index];
    VC1.tableView.scrollsToTop = YES;
    VC1.tableView.hidden = NO;
}
@end
