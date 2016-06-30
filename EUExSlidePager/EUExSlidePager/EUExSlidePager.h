//
//  EUExSlidePager.h
//  EUExSlidePager
//
//  Created by AppCan on 14-8-8.
//  Copyright (c) 2014年 AppCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuView.h"

@interface EUExSlidePager : EUExBase


@property (nonatomic, strong) MenuView * menuV;





- (void)onChangeColorCallback:(NSString *)colorStr;

@end
