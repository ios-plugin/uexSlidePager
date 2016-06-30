//
//  EUExSlidePager.m
//  EUExSlidePager
//
//  Created by AppCan on 14-8-8.
//  Copyright (c) 2014年 com.appcan. All rights reserved.
//

#import "EUExSlidePager.h"




@implementation EUExSlidePager

- (instancetype)initWithWebViewEngine:(id<AppCanWebViewEngineObject>)engine{
    self = [super initWithWebViewEngine:engine];
    if (self) {
    }
    return self;
}

-(void)openSlidePager:(NSMutableArray *)inArguments{
    
    ACArgsUnpack(NSNumber *topMarginNum,NSArray *contentArray,NSArray *iconArray,NSArray *colorArray,NSDictionary *jsonDict) = inArguments;
    
    CGFloat topMargin = topMarginNum.floatValue;

    
    if (!self.menuV) {
        self.menuV = [[MenuView alloc]initWithUexObj:self top:topMargin];
    }
    //-------------------------------------------
    
    BOOL isShowIcon = YES;
    
    if (jsonDict) {
        isShowIcon = [jsonDict[@"isShowIcon"] boolValue];
    }
    if (isShowIcon) {
        _menuV.iconArray = iconArray;
    }else{
        _menuV.iconArray= nil;
    }
    //--------------------------------------------
    _menuV.frame = CGRectMake(0, topMargin, SCREEN_WIDTH, SCREEN_HEIGHT - topMargin);
    _menuV.contentArray = contentArray;
    _menuV.colorArray = colorArray;
    [_menuV loadData];
    [_menuV setCurrentPage:0];
    [[self.webViewEngine webView]addSubview:self.menuV];
    [self onChangeColorCallback:colorArray.firstObject];
    
}

- (void)onChangeColorCallback:(NSString *)colorStr{
    [self.webViewEngine callbackWithFunctionKeyPath:@"uexSlidePager.onChangeColor" arguments:ACArgsPack(colorStr)];
}



-(void)setCurrentPage:(NSMutableArray *)inArguments{
    int index=[inArguments.firstObject intValue];
    [_menuV setCurrentPage:index];
}



-(void)closeSlidePager:(NSMutableArray *)inArguments{
    if (self.menuV) {
//        NSArray * array = [_menuV subviews];
//        for (UIView * view in array) {
//            [view removeFromSuperview];
//            NSArray * vArray = [view subviews];
//            for (UIView * vView in vArray) {
//                [vView removeFromSuperview];
//            }
//        }
        [_menuV removeFromSuperview];
        _menuV = nil;
    }
}


-(void)clean{
    
}


@end
