//
//  MainScrollView.h
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUExSlidePager.h"



@interface MainScrollView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,retain)NSArray * dataArray;
@property(nonatomic,retain)NSArray * colorArray;
@property(nonatomic)float userContentOffsetX;

@property(nonatomic,weak)EUExSlidePager * uexObj;
@property(nonatomic,assign)float margin;



+ (MainScrollView *)shareInstanceWithMargin:(float)margin;

- (void)initWithViews;



@end
