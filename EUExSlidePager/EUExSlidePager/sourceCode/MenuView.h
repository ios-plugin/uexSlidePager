//
//  MenuView.h
//  EUExSlidePager
//
//  Created by AppCan on 14-9-13.
//  Copyright (c) 2014年 com.appcan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EUExSlidePager;
@interface MenuView : UIView

@property(nonatomic,retain)NSArray * dataArray;

@property(nonatomic,retain)NSArray * contentArray;
@property(nonatomic,retain)NSArray * iconArray;
@property(nonatomic,retain)NSArray * colorArray;
@property(nonatomic,assign)float margin;
@property (nonatomic,weak)EUExSlidePager *uexObj;

@property(nonatomic,retain)UIView * backView;




- (instancetype)initWithUexObj:(EUExSlidePager *)uexObj top:(float)margin;
- (void)setCurrentPage:(int)index;
- (void)loadData;

@end
