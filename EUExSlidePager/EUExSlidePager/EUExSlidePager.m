//
//  EUExSlidePager.m
//  EUExSlidePager
//
//  Created by AppCan on 14-8-8.
//  Copyright (c) 2014年 com.appcan. All rights reserved.
//

#import "EUExSlidePager.h"
#import "EUtility.h"
#import "JSON.h"
#import "EUtility.h"
#import "Golble.h"



@implementation EUExSlidePager

-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView: eInBrwView];
    if (self) {
        //
    }
    return self;
}

-(void)openSlidePager:(NSMutableArray *)array{
    [Globle shareInstance].globleWidth = [EUtility screenWidth]; //屏幕宽度
    [Globle shareInstance].globleHeight = [EUtility screenHeight];  //屏幕高度
    NSNumber *statusBarStyleIOS7 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"StatusBarStyleIOS7"];
    if (![statusBarStyleIOS7 boolValue]) {
        [Globle shareInstance].globleHeight -= 20;
    }
    float topMargin = [[array objectAtIndex:0] floatValue];
    NSArray * contentArray = [array objectAtIndex:1];
    NSArray * iconArray = [array objectAtIndex:2] ;
    NSArray * colorArray = [array objectAtIndex:3];
    NSMutableArray *emptyArr = [NSMutableArray array];
    for (int i = 0 ; i < colorArray.count; i++) {
        [emptyArr addObject:@""];
    }
    if (!self.menuV) {
        self.menuV = [[MenuView alloc]initWithUexObj:self top:topMargin];
    }
    //-------------------------------------------
    NSString *jsonStr = nil;
    BOOL isShowIcon = YES;
    if (array.count > 4) {
        jsonStr = [array objectAtIndex:4];
        self.jsonDict = [jsonStr JSONValue];//将JSON类型的字符串转化为可变字典
        isShowIcon = [[self.jsonDict objectForKey:@"isShowIcon"] boolValue];
        
    }
    
    if (isShowIcon) {
        _menuV.iconArray = iconArray;
    }else{
        _menuV.iconArray= emptyArr;
    }
    //--------------------------------------------
    _menuV.frame=CGRectMake(0, topMargin, (float)[EUtility screenWidth], (float)[EUtility screenHeight]-topMargin);
    _menuV.contentArray=contentArray;
    _menuV.colorArray=colorArray;
    [_menuV loadData];
    [_menuV setCurrentPage:0];
    [EUtility brwView:meBrwView addSubview:_menuV];
    NSString * colorStr0=[colorArray objectAtIndex:0];
    NSString *jsstr = [NSString stringWithFormat:@"if(uexSlidePager.onChangeColor!=null){uexSlidePager.onChangeColor('%@');}",colorStr0];
    [EUtility brwView:meBrwView evaluateScript:jsstr];
    
}

-(void)setCurrentPage:(NSMutableArray *)array{
    int index=[[array objectAtIndex:0] intValue];
    [_menuV setCurrentPage:index];
}



-(void)closeSlidePager:(NSMutableArray *)array{
    if (self.menuV) {
        NSArray * array = [_menuV subviews];
        for (UIView * view in array) {
            [view removeFromSuperview];
            NSArray * vArray = [view subviews];
            for (UIView * vView in vArray) {
                [vView removeFromSuperview];
            }
        }
        [_menuV removeFromSuperview];
        _menuV = nil;
    }
}


-(void)clean{
    
}


@end
