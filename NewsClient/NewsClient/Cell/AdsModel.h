//
//  adsModel.h
//  NewsClient
//
//  Created by 大龙 on 15/11/28.
//  Copyright © 2015年 大龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdsModel : NSObject
/**
 *   "title":"全球人向往的文化旅游胜地",
 "tag":"doc",
 "imgsrc":"http://img1.126.net/channel6/2015/021729/1080624_1127b.jpg",
 "subtitle":"推广",
 "url":"B9GHKVGN00963VRO"
 */
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *imgsrc;
@property (nonatomic,strong) NSString *subtitle;
@property (nonatomic,strong) NSString *url;
@end
