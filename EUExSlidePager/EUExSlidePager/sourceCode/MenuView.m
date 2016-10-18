//
//  MenuView.m
//  EUExSlidePager
//
//  Created by xurigan on 14-9-13.
//  Copyright (c) 2014年 com.appcan. All rights reserved.
//

#import "MenuView.h"
#import "MainScrollView.h"
#import "BottomScrollView.h"


@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(instancetype)initWithUexObj:(EUExSlidePager *)uexObj top:(float)margin{
    if (self=[super init]) {
        _uexObj = uexObj;
        _margin = margin;
    }
    return self;
}

-(void)setCurrentPage:(int)index{
    [[MainScrollView shareInstanceWithMargin:1] setContentOffset:CGPointMake(index*310, 0) animated:YES];
    
    
    [[BottomScrollView shareInstanceWithMargin:1] setButtonUnSelect];
    [BottomScrollView shareInstanceWithMargin:1].scrollViewSelectedChannelID = index+100;
    [[BottomScrollView shareInstanceWithMargin:1] setButtonSelect];
    [[BottomScrollView shareInstanceWithMargin:1] setScrollViewContentOffset];
    NSString * colorStr=[_colorArray objectAtIndex:index];
    UIColor * color=[UIColor ac_ColorWithHTMLColorString:colorStr];
    [self setBackgroundColor:color];
    [self.uexObj onChangeColorCallback:colorStr];

    
}








- (void)loadData {
    if (_isShowContent) {
        MainScrollView *mainScrollView = [MainScrollView shareInstanceWithMargin:_margin];
        mainScrollView.dataArray = _contentArray;
        mainScrollView.colorArray=_colorArray;
        mainScrollView.uexObj=_uexObj;
        [mainScrollView initWithViews];
        [self addSubview:mainScrollView];
    }
   
    BottomScrollView *bottomScrollView = [BottomScrollView shareInstanceWithMargin:_margin];
    bottomScrollView.iconArray = _iconArray;
    bottomScrollView.colorArray=_colorArray;
    bottomScrollView.uexObj=_uexObj;
    [bottomScrollView initWithNameButtons];
    [self addSubview:bottomScrollView];
    
   
   
    
    
    NSString * colorStr=[_colorArray objectAtIndex:0];
    
    UIColor * color=[UIColor ac_ColorWithHTMLColorString:colorStr];
    [self setBackgroundColor:color];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
