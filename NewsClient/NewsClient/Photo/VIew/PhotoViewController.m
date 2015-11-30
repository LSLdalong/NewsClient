//
//  PhotoViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoDetailModel.h"
@interface PhotoViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSMutableArray *photoArray;
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDatas];
    self.scrollView.delegate = self;
    [self.backButton addTarget:self action:@selector(buttonBack) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // Do any additional setup after loading the view.
}
/**
 *  模态跳回
 *
 *  @return NO
 */
-(void)buttonBack{
    NSLog(@"111111");
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 *  加载图片
 *
 */
-(void)addPhotos{
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.photoArray.count, 0);
    self.titleName.text =self.name;
    self.num.text = [NSString stringWithFormat:@"1/%2ld",self.photoArray.count];
    self.subTitle.text = ((PhotoDetailModel *)self.photoArray[0]).note;
    for (int i = 0 ; i < self.photoArray.count; i++) {
        PhotoDetailModel *model = self.photoArray[i];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i ,0, [UIScreen mainScreen].bounds.size.width, self.scrollView.frame.size.height)];
        imageV.contentMode = UIViewContentModeCenter;
        imageV.contentMode =UIViewContentModeScaleAspectFit;
        NSURL *url = [NSURL URLWithString:model.imgurl];
        [imageV sd_setImageWithURL:url];
        [self.scrollView addSubview:imageV];
        self.scrollView.pagingEnabled = YES;
    }
}

/**
 *  加载数据
 */
-(void)setDatas{
    NSString *one = self.photoSetID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];
    NSString *string = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    NSLog(@"%@",string);
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = dic[@"photos"];
            self.photoArray = [PhotoDetailModel mj_objectArrayWithKeyValuesArray:array];
        }
        [self performSelectorOnMainThread:@selector(addPhotos) withObject:data waitUntilDone:YES];
    }];
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ----UIScroll代理方法 ----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x /[UIScreen mainScreen].bounds.size.width;
    self.subTitle.text = ((PhotoDetailModel *)self.photoArray[index]).note;
    self.num.text =[NSString stringWithFormat:@"%2ld/%2ld",index + 1,self.photoArray.count];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
