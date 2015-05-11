//
//  BottomScrollView.h
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUExBase.h"

@interface BottomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSArray *colorArray;


@property(nonatomic,retain)NSMutableArray *buttonOriginXArray;
@property(nonatomic,retain)NSMutableArray *buttonWithArray;


@property (nonatomic, assign)NSInteger userSelectedChannelID;        //点击按钮选择名字ID
@property (nonatomic, assign)NSInteger scrollViewSelectedChannelID;  //滑动列表选择名字ID

@property(nonatomic,retain)EUExBase * uexObj;

+ (BottomScrollView *)shareInstanceWithMargin:(float)margin;
/**
 *  加载顶部标签
 */
- (void)initWithNameButtons;
/**
 *  滑动撤销选中按钮
 */
- (void)setButtonUnSelect;
/**
 *  滑动选择按钮
 */
- (void)setButtonSelect;
/**
 *  滑动顶部标签位置适应
 */
-(void)setScrollViewContentOffset;

@end
