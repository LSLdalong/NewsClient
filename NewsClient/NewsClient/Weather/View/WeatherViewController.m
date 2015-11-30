//
//  WeatherViewController.m
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherModel.h"
#import "WeatherDetailModel.h"

@interface WeatherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rt_temperature;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *PM2_5;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *climate_wind;

@property (nonatomic,strong) WeatherModel*weatherModel;
@property (nonatomic,strong) WeatherDetailModel *weatherDetail;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDatas];
    
    // Do any additional setup after loading the view.
}
-(void)setDatas{
    NSString *string = @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.weatherModel = [WeatherModel mj_objectWithKeyValues:dic];
            self.weatherModel.detailArray = dic[@"北京|北京"];
            self.weatherDetail = [WeatherDetailModel mj_objectWithKeyValues:self.weatherModel.detailArray[0]];
            
        }
        [self performSelectorOnMainThread:@selector(reloadDatas) withObject:data waitUntilDone:YES];
    }];
    [task resume];
    
}
-(void)reloadDatas
{
    self.rt_temperature.text = [NSString stringWithFormat:@"%d",self.weatherModel.rt_temperature];
    self.temperature.text = self.weatherDetail.temperature;
    self.date.text = [NSString stringWithFormat:@"%@ %@",self.weatherModel.dt,self.weatherDetail.week];
    self.climate_wind.text = [NSString stringWithFormat:@"%@ %@",self.weatherDetail.climate,self.weatherDetail.wind];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
