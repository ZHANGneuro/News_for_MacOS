//
//  public_info.m
//  news2
//
//  Created by boo on 16/9/3.
//  Copyright © 2016年 boo. All rights reserved.
//

#import "public_info.h"


@implementation public_info

static NSMutableArray *news_list = nil;
static NSString *most_recent_time = @"01-01 00:00";
static NSString *logo_identifier;

static NSMutableArray *WangYi = nil;
static NSMutableArray *RenMinWang = nil;
static NSMutableArray *logo_image_name = nil;
static NSMutableArray *logo_name_pool = nil;
static NSString *logo_clicked = nil;
static NSMutableArray *current_array_titlePool = nil;


static BOOL IsStartup=NO;
static BOOL ImageIsLoading=NO;
static BOOL setBottomIsLoading=NO;
static BOOL ReachBottom=NO;
static BOOL checkbox_enabled=YES;
static BOOL sidebarStatus=NO;
static BOOL TopIsUpdting=NO;

static int Push_counter = 0;
static int NumNewsPush = 10;
static int Num_failednews = 0;
static int WindowWidth = 420;
static int TableImageWidth = 170;
static int RowHeight = 110;
static int SpaceWidth = 20;
static int ScrollerWidth = 10;
static int tinyRowHeight = 30;
static int sidebarWidth = 200;
static int sidebarRowHeight = 50;
static int available_news = 0;
static int rowNum_tableview = 0;

static CGFloat progress=0;
static NSColor *trackTintColor;
static NSColor *progressTintColor;
static NSColor *innerTintColor;
static CGFloat thicknessRatio;
static BOOL roundedCorners;


+ (NSMutableArray *)news_list{
    if (!news_list){
        news_list = [[NSMutableArray alloc] init];
    }
    return news_list;
}

+ (void)clear_all{
    news_list = [[NSMutableArray alloc] init];
    Num_failednews=0;
    available_news=0;
    rowNum_tableview=0;
    [self setcheckbox_enabled:YES];
}


+ (NSMutableArray*) WangYi{
    WangYi = [[NSMutableArray alloc] init];
    [WangYi addObject:@"http://temp.163.com/special/00804KVA/cm_yaowen.js?callback=data_callback"];
//    [WangYi addObject:@"http://temp.163.com/special/00804KVA/cm_yaowen_02.js?callback=data_callback"];
//    [WangYi addObject:@"http://temp.163.com/special/00804KVA/cm_yaowen_03.js?callback=data_callback"];
//    [WangYi addObject:@"http://temp.163.com/special/00804KVA/cm_yaowen_04.js?callback=data_callback"];
//    [WangYi addObject:@"http://temp.163.com/special/00804KVA/cm_yaowen_05.js?callback=data_callback"];
    return WangYi;
}


+ (NSMutableArray*) RenMinWang{
    RenMinWang = [[NSMutableArray alloc] init];
    [RenMinWang addObject:@"http://news.people.com.cn/GB/28053/index.html"];
    return RenMinWang;
}

+ (NSMutableArray*) Title_Loaded{
    if (!current_array_titlePool){
        current_array_titlePool = [[NSMutableArray alloc] init];
    }
    return current_array_titlePool;
}


+ (NSMutableArray*) logo_image_name{
    logo_image_name = [[NSMutableArray alloc] init];
    [logo_image_name addObject:@"logo_wangyi.png"];
    [logo_image_name addObject:@"logo_renminwang.png"];
    return logo_image_name;
}

+ (NSMutableArray*) logo_name_pool{
    logo_name_pool = [[NSMutableArray alloc] init];
    [logo_name_pool addObject:@"wangyi"];
    [logo_name_pool addObject:@"renminwang"];
    return logo_name_pool;
}

+ (NSString*)logo_identifier{
    return logo_identifier;
}

+ (void)setlogo_identifier:(NSString*)input{
    logo_identifier = input;
}

+ (NSString*)logo_clicked{
    return logo_clicked;
}
+ (void)setlogo_clicked:(NSString *)input{
    logo_clicked = input;
}


+ (int)Push_counter{
    return Push_counter;
}
+ (void)setPush_counter:(int)inputNum{
    Push_counter = inputNum;
}
+ (int)NumNewsPush{
    return NumNewsPush;
}
+ (void)setNumNewsPush:(int)inputNum{
    NumNewsPush = inputNum;
}


+ (BOOL)IsStartup{
    return IsStartup;
}
+ (void)setIsStartup:(BOOL)input{
    IsStartup = input;
}
+ (BOOL)TopIsUpdting{
    return TopIsUpdting;
}
+ (void)setTopIsUpdting:(BOOL)input{
    TopIsUpdting = input;
}
+ (BOOL)BottomIsLoading{
    return setBottomIsLoading;
}
+ (void)setBottomIsLoading:(BOOL)inputstatus{
    setBottomIsLoading =inputstatus;
}
+ (BOOL)ImageIsLoading{
    return ImageIsLoading;
}
+ (void)setImageIsLoading:(BOOL)inputstatus{
    ImageIsLoading = inputstatus;
}

+ (void)setReachBottom:(BOOL)inputstatus{
    ReachBottom =inputstatus;
}
+ (BOOL)ReachBottom{
    return ReachBottom;
}


+ (BOOL)sidebarIsOn{
    return sidebarStatus;
}
+ (void)setSidebarStatus:(BOOL)inputstatus{
    sidebarStatus = inputstatus;
}

+ (void)setcheckbox_enabled:(BOOL)inputstatus{
    checkbox_enabled = inputstatus;
}
+ (BOOL)checkbox_enabled{
    return checkbox_enabled;
}


+ (NSString*)most_recent_time{
    return most_recent_time;
}
+ (void)updateMost_recent_time:(NSString*)input{
    most_recent_time = input;
}


+ (void)onemore_failedNews{
    Num_failednews = Num_failednews+1;
}
+ (int)num_failedNews{
    return Num_failednews;
}


+ (int)rowNum_tableview{
    return rowNum_tableview;
}
+ (void)setRowNum_tableview:(int)inputvalue{
    rowNum_tableview = inputvalue;
}


+ (int)available_news{
    return available_news;
}
+ (void)setAvailable_news:(int)inputvalue{
    available_news = inputvalue;
}






// UI setting
+ (int)window_width{
    return WindowWidth;
}
+ (int)Table_image_width{
    return TableImageWidth;
}
+ (int)row_height{
    return RowHeight;
}
+ (int)tinyRow_height{
    return tinyRowHeight;
}
+ (int)space_width{
    return SpaceWidth;
}
+ (int)scroller_width{
    return ScrollerWidth;
}
+ (int)sidebarWidth{
    return sidebarWidth;
}
+ (int)sidebarRowHeight{
    return sidebarRowHeight;
}






// circular progress
+ (void)setProgress:(CGFloat)inputProgress{
    progress = inputProgress;
}
+ (CGFloat)progress{
    return progress;
}
+ (NSColor *)trackTintColor{
    return trackTintColor;
}
+ (void)setTrackTintColor:(NSColor *)input{
    trackTintColor = input;
}

+ (NSColor *)progressTintColor{
    return progressTintColor;
}
+ (void)setProgressTintColor:(NSColor *)input{
    progressTintColor = input;
}

+ (NSColor *)innerTintColor{
    return innerTintColor;
}
+ (void)setInnerTintColor:(NSColor *)input{
    innerTintColor = input;
}

+ (BOOL)roundedCorners{
    return roundedCorners;
}
+ (void)setRoundedCorners:(BOOL)input{
    roundedCorners =input;
}

+ (CGFloat)thicknessRatio{
    return thicknessRatio;
}
+ (void)setThicknessRatio:(CGFloat)input{
    thicknessRatio = input;
}



@end
