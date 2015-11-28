//
//  NewsTableViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "DetailViewController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "AdsModel.h"
#import "PageCell.h"
@interface NewsTableViewController()<UIScrollViewDelegate>
/**
 *  定义一个pageControl接受scorll的page,label,text
 */
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) NSArray *adsArray;
@property (nonatomic,strong) UIPageControl *pageC;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSMutableArray *arrayNews;

/**
 *  增加定时器
 */
@property (nonatomic,strong) NSTimer *timer;
@end
@implementation NewsTableViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView.mj_header beginRefreshing];
}
-(void)viewDidLoad{
    
   // self.tableView.backgroundColor = [UIColor greenColor];
    //self.view.backgroundColor = [UIColor cyanColor];
    [self.tableView.mj_header beginRefreshing];
    /**
     *  加载数据
     */
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/0-20.html",self.urlString];
    NSURL *url = [NSURL URLWithString:string];
    [self setData:url Type:1];
    
    /**
     *  下拉刷新
     */
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    /**
     *  上拉刷新
     */
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
#pragma mark ----上拉下拉加载数据 ----
/**
 *  下拉刷新
 */
-(void)refreshData
{
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/0-20.html",self.urlString];
    NSURL *url = [NSURL URLWithString:string];
    [self setData:url Type:1];
//    dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *1);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        [self.tableView.mj_header endRefreshing];
//    });
   [self.tableView.mj_header endRefreshing];
    
}
/**
 *  上拉加载更多数据
 */
-(void)loadMoreData
{
    NSString *string =[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/%ld-20.html",self.urlString,self.arrayNews.count - self.arrayNews.count%10];
    NSURL *url = [NSURL URLWithString:string];
    [self setData:url Type:2];
    /**
     *  延时1秒刷新
     */
//    dispatch_time_t time= dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC *1);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        [self.tableView.mj_footer endRefreshing];
//    });
    
    [self.tableView.mj_footer endRefreshing];
    

}

/**
 *  懒加载
 */
-(NSMutableArray *)arrayNews{
    if(_arrayNews == nil){
        _arrayNews = [NSMutableArray array];
    }
    return _arrayNews;
}
/**
 *  解析数据
 *
 */
-(void)setData:(NSURL *)url
          Type:(NSInteger)type{
//    NSString *string = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html";
//    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
           // NSLog(@"%@",dic);
            /**
             *  得到键值
             */
            NSString *key = [dic.keyEnumerator nextObject];
            NSMutableArray *array =dic[key];
            NSMutableArray *arrayM = [NewsModel mj_objectArrayWithKeyValuesArray:array];
            NewsModel *model =  arrayM.firstObject;
            NSMutableArray *arrayAds = [array.firstObject objectForKey:@"ads"];
            model.ads = [AdsModel mj_objectArrayWithKeyValuesArray:arrayAds];
            if (type == 1) {
                self.arrayNews = arrayM;
                
            }
            else if(type == 2){
                [self.arrayNews addObjectsFromArray:arrayM];
                
            }
//            for (NSDictionary *dic in array) {
//                NewsModel *newsModel =[[NewsModel alloc] init];
//                [newsModel setValuesForKeysWithDictionary:dic];
//                [self.arrayNews addObject:newsModel];
//                NSLog(@"%@",newsModel);
//            }
        }
        [self performSelectorOnMainThread:@selector(reloadDatas) withObject:data waitUntilDone:YES];
    }];
    [task resume];
    
}

/**
 *  重新加载数据
 *
 */

-(void)reloadDatas{
    [self.tableView reloadData];
}
#pragma mark ----设置tableview ----
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayNews.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = self.arrayNews[indexPath.row];
    NSLog(@"%ld",indexPath.row);
    NSString *cell_id = [NewsTableViewCell idForRow:newsModel];
    if ([cell_id isEqualToString:@"PageCell"]) {
        PageCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        [cell setPropertyOfCell:newsModel Number:(newsModel.ads.count)];
        /**
         *  把边界条去掉
         */
        cell.scroll.showsHorizontalScrollIndicator = NO;
        cell.scroll.shouldGroupAccessibilityChildren = NO;
        //设置轮播图的代理
        self.scroll = cell.scroll;
        cell.scroll.delegate = self;
        self.pageC = cell.pageControl;
        self.pageC.numberOfPages = newsModel.ads.count +1;
        self.pageC.currentPage = 0;
        self.text = newsModel.title;
        
        self.label = cell.label;
        self.adsArray = newsModel.ads;
        /**
         *  增加定时器
         */
       // self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        /**
         *  将定时器加到runloop中
         */
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        return cell;
       


    }
    else{
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
        cell.newsModel = newsModel;
        return cell;
    }
    
}

/**
 *  定时器改变图片
 */
//-(void)nextImage{
//    static NSInteger i = 0;
//    if (i == self.adsArray.count) {
//        i = 0;
//        self.scroll.contentOffset = CGPointMake(self.scroll.frame.size.width *i, 0);
//        return;
//    }
//    self.scroll.contentOffset = CGPointMake(self.scroll.frame.size.width *(i+1), 0);
//    self.pageC.currentPage = i+1;
//    if (i == 0 ) {
//        self.label.text = self.text;
//    }
//    else{
//        
//        self.label.text =((AdsModel *)(self.adsArray[i])).title;
//    }

//    i++;
//
//}

/**
 *  轮播图的代理方法
 *
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
#if 0
   // [super scrollViewDidEndDecelerating:nil];
    NSInteger num   =scrollView.contentOffset.x / scrollView.frame.size.width;
    NSInteger numMax = scrollView.contentSize.width / scrollView.frame.size.width;
    self.pageC.currentPage = num-1;
//    if (num == 1 ) {
//        self.label.text = self.text;
//    }
//    else if( num < (numMax - 1)&&num > 0 ){
//        
//        self.label.text =((AdsModel *)(self.adsArray[num-2])).title;
//    }
//    else if(num == numMax - 1){
//        self.label.text =self.text;
//    }
//    CGFloat location = scrollView.contentOffset.x;
//    if (location < scrollView.frame.size.width) {
//        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width *(numMax - 2), 0)];
//        self.pageC.currentPage = numMax - 2;
//    }
//    if (location > scrollView.frame.size.width *(numMax - 2)) {
//        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width , 0)];
//        self.pageC.currentPage = 0;
//    }
//
//
#else
    NSInteger num   =self.scroll.contentOffset.x / self.scroll.frame.size.width;
    NSInteger numMax = self.scroll.contentSize.width / self.scroll.frame.size.width;
    self.pageC.currentPage = num-1;
        if (num == 1 ) {
            self.label.text = self.text;
        }
        else if( num < (numMax - 1)&&num > 0 ){
    
            self.label.text =((AdsModel *)(self.adsArray[num-2])).title;
        }
        else if(num == numMax - 1){
            self.label.text =self.text;
        }
        CGFloat location = self.scroll.contentOffset.x;
        if (location < self.scroll.frame.size.width) {
            [self.scroll setContentOffset:CGPointMake(self.scroll.frame.size.width *(numMax - 2), 0)];
            self.pageC.currentPage = numMax - 2;
        }
        if (location > self.scroll.frame.size.width *(numMax - 2)) {
            [self.scroll setContentOffset:CGPointMake(self.scroll.frame.size.width , 0)];
            self.pageC.currentPage = 0;
        }
    
    
    
#endif
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *newsModel = self.arrayNews[indexPath.row];
    CGFloat height = [NewsTableViewCell heightForRow:newsModel];
    return height;
}
/**
 *  跳转传递参数
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        DetailViewController *detailVC = segue.destinationViewController;
        NSInteger row = self.tableView.indexPathForSelectedRow.row;
        detailVC.newsModel = self.arrayNews[row];
    }
}
@end
