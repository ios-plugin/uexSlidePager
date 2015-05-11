//
//  Golble.h
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)


#define COEFFICIENT ([UIScreen mainScreen].bounds.size.width/320.0)

@interface Globle : NSObject

@property (nonatomic,assign) float globleWidth;
@property (nonatomic,assign) float globleHeight;
@property (nonatomic,assign) float globleAllHeight;

+ (Globle *)shareInstance;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end
