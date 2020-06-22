//
//  public_info.h
//  news2
//
//  Created by boo on 16/9/3.
//  Copyright © 2016年 boo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "parse_method.h"
#import <AppKit/AppKit.h>

@interface public_info : NSObject

+ (NSMutableArray*) news_list;
+ (void)clear_all;

+ (NSMutableArray*) WangYi;
+ (NSMutableArray*) RenMinWang;

+ (NSString*)most_recent_time;
+ (void)updateMost_recent_time:(NSString*)input;
+ (NSMutableArray*) Title_Loaded;

+ (int)Push_counter;
+ (void)setPush_counter:(int)inputNum;
+ (int)NumNewsPush;
+ (void)setNumNewsPush:(int)inputNum;

+ (BOOL)IsStartup;
+ (void)setIsStartup:(BOOL)input;

+ (BOOL)TopIsUpdting;
+ (void)setTopIsUpdting:(BOOL)input;

+ (BOOL)BottomIsLoading;
+ (void)setBottomIsLoading:(BOOL)inputstatus;

+ (BOOL)ImageIsLoading;
+ (void)setImageIsLoading:(BOOL)inputstatus;



+ (BOOL)ReachBottom;
+ (void)setReachBottom:(BOOL)inputstatus;

+ (BOOL)checkbox_enabled;
+ (void)setcheckbox_enabled:(BOOL)inputstatus;






+ (NSMutableArray*) logo_image_name;
+ (NSMutableArray*) logo_name_pool;

+ (NSString*)logo_identifier;
+ (void)setlogo_identifier:(NSString*)input;


+ (NSString*)logo_clicked;
+ (void)setlogo_clicked:(NSString*)input;

+ (BOOL)sidebarIsOn;
+ (void)setSidebarStatus:(BOOL)inputstatus;




+ (int)available_news;
+ (void)setAvailable_news:(int)inputvalue;

+ (int)rowNum_tableview;
+ (void)setRowNum_tableview:(int)inputvalue;

+ (void)onemore_failedNews;
+ (int)num_failedNews;

+ (int)window_width;
+ (int)Table_image_width;
+ (int)row_height;
+ (int)tinyRow_height;
+ (int)space_width;
+ (int)scroller_width;
+ (int)sidebarWidth;
+ (int)sidebarRowHeight;

+ (CGFloat)progress;
+ (void)setProgress:(CGFloat)inputProgress;

+ (NSColor *)trackTintColor;
+ (void)setTrackTintColor:(NSColor *)input;

+ (NSColor *)progressTintColor;
+ (void)setProgressTintColor:(NSColor *)input;

+ (NSColor *)innerTintColor;
+ (void)setInnerTintColor:(NSColor *)input;

+ (BOOL)roundedCorners;
+ (void)setRoundedCorners:(BOOL)input;

+ (CGFloat)thicknessRatio;
+ (void)setThicknessRatio:(CGFloat)input;

@end
