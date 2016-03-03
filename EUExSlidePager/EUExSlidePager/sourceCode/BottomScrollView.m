//
//  BottomScrollView.m
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan All rights reserved.
//

#import "BottomScrollView.h"
#import "Golble.h"
#import "MainScrollView.h"
#import "EUtility.h"

//按钮空隙
#define BUTTONGAP (320*COEFFICIENT-(40*COEFFICIENT*7))/7
//滑条宽度
#define CONTENTSIZEX 320*COEFFICIENT
//按钮id
#define BUTTONID (sender.tag-100)

@implementation BottomScrollView

+ (BottomScrollView *)shareInstanceWithMargin:(float)margin {
    static BottomScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[self alloc] initWithFrame:CGRectMake(0, [Globle shareInstance].globleHeight-40*COEFFICIENT-margin, [Globle shareInstance].globleWidth, 40*COEFFICIENT)];
        
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        _userSelectedChannelID = 100;
        _scrollViewSelectedChannelID = 100;
        self.canCancelContentTouches = NO;
        self.delaysContentTouches = NO;
    }
    return self;
}

- (void)initWithNameButtons
{
    self.buttonOriginXArray = [NSMutableArray array];
    self.buttonWithArray = [NSMutableArray array];
    float xPos = (320*COEFFICIENT-(40*COEFFICIENT*7))/7;
    for (int i = 0; i < [_colorArray count]; i++) {
        NSString * iconStr;
        if (_dataArray ) {
            iconStr=[_dataArray objectAtIndex:i];
        }else{
            return;
        }
        NSString * imageURL = [_uexObj absPath:iconStr];
        UIView *iconView=[[UIView alloc]initWithFrame:CGRectMake(xPos, 35*COEFFICIENT, 40*COEFFICIENT, 40*COEFFICIENT)];
        iconView.layer.cornerRadius = 4*COEFFICIENT;
        iconView.layer.masksToBounds = YES;
        [iconView setBackgroundColor:[UIColor whiteColor]];
        //        iconView.alpha=0.5;
        UIImageView * iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*COEFFICIENT, 2*COEFFICIENT, 36*COEFFICIENT, 36*COEFFICIENT)];
        iconImg.image=[UIImage imageWithContentsOfFile:imageURL];
        [iconView addSubview:iconImg];
        iconView.tag=100+i;
        if (i==0) {
            CGRect rect=iconView.frame;
            rect.origin.y-=35*COEFFICIENT;
            iconView.frame=rect;
        }
        [_buttonOriginXArray addObject:@(xPos)];
        
        xPos += iconView.frame.size.width+(320*COEFFICIENT-(40*COEFFICIENT*7))/7;
        
        [_buttonWithArray addObject:@(iconView.frame.size.width)];
        [self addSubview:iconView];
    }
    
    self.contentSize = CGSizeMake(xPos, 0);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */



- (void)adjustScrollViewContentX:(UIButton *)sender
{
    float originX = [[_buttonOriginXArray objectAtIndex:BUTTONID] floatValue];
    float width = [[_buttonWithArray objectAtIndex:BUTTONID] floatValue];
    
    if (sender.frame.origin.x - self.contentOffset.x > CONTENTSIZEX-(BUTTONGAP+width)) {
        [self setContentOffset:CGPointMake(originX - 40*COEFFICIENT, 0)  animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 5*COEFFICIENT) {
        [self setContentOffset:CGPointMake(originX,0)  animated:YES];
    }
}


- (void)setButtonUnSelect
{
    //滑动撤销选中按钮
    UIView *lastButton = (UIView *)[self viewWithTag:_scrollViewSelectedChannelID];
    CGRect rect=lastButton.frame;
    rect.origin.y=35*COEFFICIENT;
    [UIView animateWithDuration:0.25 animations:^{
        lastButton.frame=rect;
    }];
}

- (void)setButtonSelect
{
    //滑动选中按钮
    UIView *button = (UIView *)[self viewWithTag:_scrollViewSelectedChannelID];
    CGRect rect=button.frame;
    rect.origin.y=35*COEFFICIENT;
    rect.origin.y-=35*COEFFICIENT;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        button.frame=rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            _userSelectedChannelID = button.tag;
        }
    }];
    for (int i = 0; i < [_dataArray count]; i++) {
        UIView *button1 = (UIView *)[self viewWithTag:i+100];
        if (i+100!=_scrollViewSelectedChannelID) {
            CGRect rect1=button1.frame;
            rect1.origin.y=35*COEFFICIENT;
            [UIView animateWithDuration:0.25 animations:^{
                button1.frame=rect1;
            }];
        }
    }
    
    
    
}

- (void)setButtonNearSelect
{
    //滑动选中按钮
    UIView *button = (UIView *)[self viewWithTag:_scrollViewSelectedChannelID];
    CGRect rect=button.frame;
    rect.origin.y=  0;
    button.frame=rect;
    for (int i=1; i<7; i++) {
        if ((UIView *)[self viewWithTag:_scrollViewSelectedChannelID+i]) {
            UIView *button1 = (UIView *)[self viewWithTag:_scrollViewSelectedChannelID+i];
            CGRect rect1=button1.frame;
            rect1.origin.y=i*5*COEFFICIENT;
            [UIView animateWithDuration:0.1 animations:^{
                button1.frame=rect1;
            }];
        }
        if ((UIView *)[self viewWithTag:_scrollViewSelectedChannelID-i]) {
            UIView *button2 = (UIView *)[self viewWithTag:_scrollViewSelectedChannelID-i];
            CGRect rect2=button2.frame;
            rect2.origin.y=i*5*COEFFICIENT;
            [UIView animateWithDuration:0.1 animations:^{
                button2.frame=rect2;
            }];
        }
    }
    
}

-(void)setScrollViewContentOffset
{
    if (_buttonOriginXArray.count == 0) {
        return;
    }
    int index=(int)_scrollViewSelectedChannelID - 100;
    if (index>=_buttonOriginXArray.count) {
        index=(int)_buttonOriginXArray.count-1;
    }
    float originX = [[_buttonOriginXArray objectAtIndex:index] floatValue];
    float width = [[_buttonWithArray objectAtIndex:index] floatValue];
    
    if (index>3 && index<_buttonOriginXArray.count-3) {
        [self setContentOffset:CGPointMake(originX-3*width-3*BUTTONGAP, 0) animated:YES];
    }
    if (index<=3) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (index>=_buttonOriginXArray.count-3) {
        [self setContentOffset:CGPointMake(self.contentSize.width-7*width-7*BUTTONGAP, 0) animated:YES];
    }
}

//********
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { //在这里设置scrollView的属性 //
    self.scrollEnabled = NO;
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        CGPoint location = [touch locationInView:self];
        int loc=location.x/(BUTTONGAP+40*COEFFICIENT);
        self.scrollViewSelectedChannelID = loc+100;
        [self setButtonNearSelect];
    }];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        CGPoint location = [touch locationInView:self];
        int loc=location.x/(BUTTONGAP+40*COEFFICIENT);
        if (loc>=_buttonOriginXArray.count) {
            loc=(int)_buttonOriginXArray.count-1;
        }
        self.scrollViewSelectedChannelID = loc+100;
        [self setButtonNearSelect];
    }];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { //在这里设置scrollView的属性 //
    self.scrollEnabled = YES;
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch * touch = obj;
        CGPoint location = [touch locationInView:self];
        int loc=location.x/(BUTTONGAP+40*COEFFICIENT);
        if (loc>=_buttonOriginXArray.count) {
            loc=(int)_buttonOriginXArray.count-1;
        }
        [self setButtonUnSelect];
        self.scrollViewSelectedChannelID = loc+100;
        [self setButtonSelect];
        [self setScrollViewContentOffset];
        [self selectNameButton:loc];
        
        NSString * colorStr=[_colorArray objectAtIndex:loc];
        UIColor * color=[EUtility ColorFromString:colorStr];
        [self.superview setBackgroundColor:color];
        NSString *jsstr = [NSString stringWithFormat:@"if(uexSlidePager.onChangeColor!=null){uexSlidePager.onChangeColor('%@');}",colorStr];
        [EUtility brwView:_uexObj.meBrwView evaluateScript:jsstr];
    }];
}

- (void)selectNameButton:(int)index
{
    [[MainScrollView shareInstanceWithMargin:1] setContentOffset:CGPointMake(index*320*COEFFICIENT, 0) animated:YES];
}


@end
