//
//  MenuView.h
//  EUExSlidePager
//
//  Created by AppCan on 14-9-13.
//  Copyright (c) 2014年 com.appcan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUExBase.h"

@interface MenuView : UIView

@property(nonatomic,retain)NSArray * dataArray;

@property(nonatomic,retain)NSArray * contentArray;
@property(nonatomic,retain)NSArray * iconArray;
@property(nonatomic,retain)NSArray * colorArray;
@property(nonatomic,assign)float margin;
@property(nonatomic,retain)EUExBase * uexObj;
@property(nonatomic,retain)UIView * backView;

-(id)initWithUexObj:(EUExBase*)uexObj top:(float)margin;
-(void)setCurrentPage:(int)index;
-(void)loadData;

@end
