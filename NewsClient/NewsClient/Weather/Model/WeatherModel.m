//
//  WeatherModel.m
//  NewsClient
//
//  Created by 大龙 on 15/11/30.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import "WeatherModel.h"
@implementation WeatherModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"北京|北京"]) {
        self.detailArray = value;
    }
    
}
@end
