//
//  WeatherDetailModel.h
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDetailModel : NSObject
/** 什么风*/
@property(nonatomic,copy)NSString *wind;
/** 农历*/
@property(nonatomic,copy)NSString *nongli;
/** 日期*/
@property(nonatomic,copy)NSString *date;
/** 天气*/
@property(nonatomic,copy)NSString *climate;
/** 温度*/
@property(nonatomic,copy)NSString *temperature;
/** 星期几*/
@property(nonatomic,copy)NSString *week;
@end
