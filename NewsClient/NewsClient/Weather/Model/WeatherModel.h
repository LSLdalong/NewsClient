//
//  WeatherModel.h
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject
@property(nonatomic,strong)NSArray *detailArray;
//@property(nonatomic,strong)NSString *pm2d5;
@property(nonatomic,copy)NSString *dt;
@property(nonatomic,assign)int rt_temperature;
@end
