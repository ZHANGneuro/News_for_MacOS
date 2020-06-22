//
//  AppDelegate.h
//  news2
//
//  Created by boo on 15/8/7.
//  Copyright (c) 2015年 boo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "myTableView.h"
#import "myScrollView.h"
#import "sidebar.h"
#import "fliped_view.h"
#import <CoreImage/CoreImage.h>
#import "cover_view.h"
#import "brands_turbo.h"
#import "DACircularProgressView.h"
#import "wangyi_lobby.h"



@interface AppDelegate : NSObject <NSApplicationDelegate>
@property NSWindow *window;
@property NSTitlebarAccessoryViewController *dummyTitlebarAccessoryViewController;
@property NSButton *sidebar_button;
@property NSButton *back_button;
@property NSView *titlebar;
@property cover_view *news_cover_view;
@property myScrollView* scrollview;
@property sidebar* sideBarView;
@property NSView *titleBarView;
@property NSVisualEffectView *transView;
@property fliped_view *win_contentview;
@property fliped_view *fanzhuan_view;
@property NSScrollView* scrollView_2nd;
@property myTableView* mytableview;
@property DACircularProgressView *labeledProgressView;
@property NSTimer *timer;
@property BOOL reload_news;

@end















