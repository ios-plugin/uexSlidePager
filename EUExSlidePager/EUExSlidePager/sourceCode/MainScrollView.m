//
//  MainScrollView.m
//  EUExDemo
//
//  Created by AppCan on 14-8-6.
//  Copyright (c) 2014年 AppCan. All rights reserved.
//

#import "MainScrollView.h"

//#import "myContentView.h"
#import "BottomScrollView.h"
#import "FileEncrypt.h"

#define POSITIONID (int)(scrollView.contentOffset.x/(320.0*COEFFICIENT))

@implementation MainScrollView

+ (MainScrollView *)shareInstanceWithMargin:(float)margin {
    NSNumber *statusBarStyleIOS7 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"StatusBarStyleIOS7"];
    if (![statusBarStyleIOS7 boolValue]) {
        margin-=20;
    }
    static MainScrollView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _instance=[[self alloc] initWithFrame:CGRectMake(0, 5*COEFFICIENT, SCREEN_WIDTH, SCREEN_HEIGHT-80*COEFFICIENT-margin)];
    });
    return _instance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        
//        self.canCancelContentTouches = NO;
        self.delaysContentTouches = NO;
        
        _userContentOffsetX = 0;
    }
    return self;
}


-(void)tap:(id)sender{
    UIButton * btn=(UIButton*)sender;
    [self.uexObj.webViewEngine callbackWithFunctionKeyPath:@"uexSlidePager.onPageClick" arguments:ACArgsPack(@(btn.tag))];
}

-(BOOL)isEncrypted:(NSData *)srcData_{
    if (srcData_==nil) {
        return NO;
    }
    NSData *subdata = [srcData_ subdataWithRange:NSMakeRange([srcData_ length]-17,17)];
    NSString *substr = [[NSString alloc] initWithData:subdata encoding:NSUTF8StringEncoding];
    
    BOOL retVal =[substr isEqualToString:@"3G2WIN Safe Guard"];
    return retVal;
}


- (void)initWithViews
{                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    
    
    for (int i = 0; i < [_dataArray count]; i++) {
        NSString * filePath=[_dataArray objectAtIndex:i];
        
        filePath = [_uexObj absPath:filePath];
        
        
        UIWebView * webView=[[UIWebView alloc]initWithFrame:CGRectMake(10*COEFFICIENT+320*COEFFICIENT*i, 0, 300*COEFFICIENT, self.frame.size.height)];
        NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        
        if (![filePath hasPrefix:@"file"]) {
            filePath = [NSString stringWithFormat:@"file://%@",filePath];
        }
        
        
        NSURL * url = [NSURL URLWithString:filePath];
        NSData *srcData = [NSData dataWithContentsOfURL:url];
        if ([self isEncrypted:srcData]) {
            FileEncrypt *encryptObj = [[FileEncrypt alloc]init];
            htmlString = [encryptObj decryptWithPath:url appendData:nil];
        }
        
        
        
        
        [webView loadHTMLString:htmlString baseURL:url];
        [self addSubview:webView];
        webView.userInteractionEnabled=YES;
        webView.scrollView.scrollEnabled=NO;
        

        webView.layer.cornerRadius = 50/2;
        webView.layer.masksToBounds = YES;
        webView.scalesPageToFit=YES;
        
        UIButton * btn=[[UIButton alloc]initWithFrame:CGRectMake(70*COEFFICIENT+320*COEFFICIENT*i, 40*COEFFICIENT, 180*COEFFICIENT, self.frame.size.height-60*COEFFICIENT)];
//        btn.backgroundColor=[UIColor redColor];
        [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.tag=i;
        btn.titleLabel.text=[NSString stringWithFormat:@"%d",i];
    }
    self.contentSize = CGSizeMake(320*COEFFICIENT*[_dataArray count], self.frame.size.height);
}

//滚动后修改底部滚动条
- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView
{
    [[BottomScrollView shareInstanceWithMargin:1] setButtonUnSelect];
    ACLogDebug(@"POSITIONID==>%d,%f,%f",POSITIONID,scrollView.contentOffset.x,COEFFICIENT*320);
    [BottomScrollView shareInstanceWithMargin:1].scrollViewSelectedChannelID = POSITIONID+100;
    [[BottomScrollView shareInstanceWithMargin:1] setButtonSelect];
    [[BottomScrollView shareInstanceWithMargin:1] setScrollViewContentOffset];
    NSString * colorStr=[_colorArray objectAtIndex:POSITIONID];
    UIColor * color=[UIColor ac_ColorWithHTMLColorString:colorStr];
    
    [self.superview setBackgroundColor:color];
    [self.uexObj onChangeColorCallback:colorStr];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    _userContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (_userContentOffsetX < scrollView.contentOffset.x) {
//        isLeftScroll = YES;
//    }
//    else {
//        isLeftScroll = NO;
//    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];
//
//    [self loadData];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    [self loadData];
}



@end
