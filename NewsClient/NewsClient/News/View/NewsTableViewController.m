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
@interface NewsTableViewController()
@property (nonatomic,strong) NSMutableArray *arrayNews;
@end
@implementation NewsTableViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor cyanColor];
    [self setData];
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
-(void)setData{
    NSString *string = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html";
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",dic);
            NSMutableArray *array =dic[@"T1348647853363"];
            
            for (NSDictionary *dic in array) {
                NewsModel *newsModel =[[NewsModel alloc] init];
                [newsModel setValuesForKeysWithDictionary:dic];
                [self.arrayNews addObject:newsModel];
                NSLog(@"%@",newsModel);
            }
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
    NSString *cell_id = [NewsTableViewCell idForRow:newsModel];
 //   NSString *cell_id = @"ImagesCell";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.newsModel = newsModel;
    return cell;
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
