//
//  TopScrollView.m
//  NewsClient
//
//  Created by 大龙 on 15/11/26.
//  Copyright © 2015年 大龙. All rights reserved.
//


#import "TopScrollView.h"

@implementation TopScrollView

/**
 *  加载XIB时会调用这个方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addLabelViews];
    }
    return self;
}

//-(void)awakeFromNib
//{
//    [self addLabelViews];
//}

-(void)addLabelViews{
    self.contentSize = CGSizeMake(LABELWIDTH * 8, 0);
    self.showsHorizontalScrollIndicator = NO;
   // self.pagingEnabled = YES;
    NSArray *headLabelArray = @[@"头条",@"NBA",@"手机",@"移动互联",@"娱乐",@"时尚",@"电影",@"科技"];
//    for (int i = 0; i < headLabelArray.count; i++) {
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * LABELWIDTH, 0, LABELWIDTH, self.bounds.size.height)];
//        label.text = headLabelArray[i];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor blackColor];
//        label.font = [UIFont systemFontOfSize:12];
//        [self addSubview:label];
//        if(i == 0){
//            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
//            
//        }
// }
    /**
     *  设置Scroll中的Button
     */
    for (int i = 0; i < headLabelArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * LABELWIDTH, 0, LABELWIDTH, self.bounds.size.height)];
        button.tag = 200+i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:headLabelArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        else{
            button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        }
        [self addSubview:button];
    }
    
    
}
-(void)buttonAction:(UIButton *)button{
    __weak typeof(self) weakSelf = self;
    NSInteger index =  [weakSelf.subviews indexOfObject:button];

    self.buttonJump(index);
}

@end
