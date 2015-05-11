//
//  MainScrollView.h
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUExBase.h"



@interface MainScrollView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,retain)NSArray * dataArray;
@property(nonatomic,retain)NSArray * colorArray;
@property(nonatomic)float userContentOffsetX;

@property(nonatomic,retain)EUExBase * uexObj;
@property(nonatomic,assign)float margin;



+ (MainScrollView *)shareInstanceWithMargin:(float)margin;

- (void)initWithViews;



@end
