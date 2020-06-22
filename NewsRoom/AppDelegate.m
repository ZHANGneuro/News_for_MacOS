//
//  AppDelegate.m
//  news2
//
//  Created by boo on 15/8/7.
//  Copyright (c) 2015年 boo. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize window,titlebar,sidebar_button,scrollview,sideBarView,fanzhuan_view,scrollView_2nd,mytableview,back_button,titleBarView,news_cover_view,transView,timer,labeledProgressView, win_contentview, reload_news;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    // set up a window
    int appheight = [[NSScreen mainScreen] frame].size.height;
    NSRect frame = NSMakeRect(50, appheight, 420, appheight*0.65);
    NSUInteger masks = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable |NSWindowStyleMaskBorderless;
    window = [[NSWindow alloc] initWithContentRect:frame styleMask:masks backing:NSBackingStoreBuffered defer:NO];
    [window makeKeyAndOrderFront:NSApp];
    [window setTitlebarAppearsTransparent:NO];
    [window setMaxSize:NSMakeSize(420, appheight)];
    [window setMinSize:NSMakeSize(420, appheight/2)];
    [window setAcceptsMouseMovedEvents:YES];
    win_contentview = [[fliped_view alloc] initWithFrame:NSMakeRect(0, 0, 420, appheight)];
    [window setContentView:win_contentview];
    [window.contentView setCanDrawConcurrently:YES];
    [window setAcceptsMouseMovedEvents:YES];
    
    window.backgroundColor = [NSColor colorWithCalibratedRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
    // notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(window_resize:) name:NSWindowDidResizeNotification object:window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollEnd:) name:NSScrollViewDidEndLiveScrollNotification object:scrollview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sidebar_Clicked) name:@"close_sidebar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update_start) name:@"update_start" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update_end:) name:@"update_end" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remove_row:) name:@"remove_row" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add_row:) name:@"add_row" object:nil];
    
    // add a newview (fake toolbar view) on NStitlebarview
    [[[window standardWindowButton:NSWindowCloseButton] superview] addSubview:titlebar];
    // addTitlebarAccessoryViewController
    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 20, 16)];//16
    _dummyTitlebarAccessoryViewController = [NSTitlebarAccessoryViewController new];
    _dummyTitlebarAccessoryViewController.view = view;
    _dummyTitlebarAccessoryViewController.fullScreenMinHeight = 38;
    [window addTitlebarAccessoryViewController:_dummyTitlebarAccessoryViewController];
    // set up traffic light
    [self adjust_traffic_light];
    [self add_sidebar_button];
    
    // set up cover_view
    news_cover_view = [[cover_view alloc] initWithFrame:scrollview.frame];
    // set up updating circle
    labeledProgressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(([public_info window_width]-50)/2, 45, 50, 50)];
    [window.contentView addSubview:labeledProgressView];
    
    // create scrollview
    scrollview = [[myScrollView alloc] initWithFrame:window.contentView.frame];
    [scrollview setHasVerticalScroller:YES];
    [scrollview setHasHorizontalScroller:NO];
    [scrollview setBorderType:NSNoBorder];
    myscroller *scroller = [[myscroller alloc] initWithFrame:scrollview.verticalScroller.frame];
    [scrollview setVerticalScroller:scroller];
    
    // create sidebar
    transView = [[NSVisualEffectView alloc] initWithFrame:NSMakeRect(-[public_info sidebarWidth], 0, [public_info sidebarWidth], window.contentView.frame.size.height)];
    sideBarView = [[sidebar alloc] initWithFrame:transView.frame];
    
    // create tableview
    mytableview = [[myTableView alloc] initWithFrame:scrollview.frame];
    [mytableview setAction:@selector(enter_2nd_page:)];
    
    // add all views
    [transView addSubview:sideBarView];
    [window.contentView addSubview:transView];
    [scrollview setDocumentView:mytableview];
    [window.contentView addSubview:scrollview];
    reload_news = NO;
    
    //trackingarea
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSMakeRect(0, 0, 20, appheight)
                                                                options:NSTrackingMouseEnteredAndExited |NSTrackingActiveAlways
                                                                  owner:self
                                                               userInfo:nil];
    [window.contentView addTrackingArea:trackingArea];
    
    [public_info setIsStartup:YES];
    [brands_turbo collected_brands:@"startup"];
    
}

-(void)remove_row:(NSNotification *)notification{
    [mytableview removeFromSuperview];
    reload_news = YES;
    NSLog(@"%@",@"remove_row");
    [public_info clear_all];
}

-(void)add_row:(NSNotification *)notification{
    if (reload_news==YES) {
        mytableview = [[myTableView alloc] initWithFrame:scrollview.frame];
        [mytableview setAction:@selector(enter_2nd_page:)];
        [scrollview setDocumentView:mytableview];
        [wangyi_lobby get:@"startup"];
        //        reload_news = NO;
    } else {
        [wangyi_lobby get:@"startup"];
    }
}

- (void)mouseEntered:(NSEvent *)event {
    [self sidebar_open];
}
- (void)mouseExited:(NSEvent *)event {
}


-(void) sidebar_Clicked{
    if (![public_info sidebarIsOn]){
        [self sidebar_open];
    } else if ([public_info sidebarIsOn]){
        [self sidebar_close];
    }
}

-(void) sidebar_open{
    [[transView animator] setFrame:NSMakeRect(0, 0, [public_info sidebarWidth], window.contentView.frame.size.height)];
    [[sideBarView animator] setFrame:NSMakeRect(0, 0, [public_info sidebarWidth], window.contentView.frame.size.height)];
    [[scrollview animator] setFrame:NSMakeRect([public_info sidebarWidth], 0, window.contentView.frame.size.width, window.contentView.frame.size.height)];
    [news_cover_view setFrame:scrollview.documentView.frame];
    [scrollview addSubview:news_cover_view];
    [public_info setSidebarStatus:YES];
}
-(void) sidebar_close{
    [[transView animator] setFrame:NSMakeRect(-[public_info sidebarWidth], 0, [public_info sidebarWidth], window.contentView.frame.size.height)];
    [[sideBarView animator] setFrame:NSMakeRect(-[public_info sidebarWidth], 0, [public_info sidebarWidth], window.contentView.frame.size.height)];
    [[scrollview animator] setFrame:NSMakeRect(0, 0, window.contentView.frame.size.width, window.contentView.frame.size.height)];
    [news_cover_view removeFromSuperview];
    [public_info setSidebarStatus:NO];
}


- (void)update_start{
    NSLog(@"%@",@"start");
    [public_info setTopIsUpdting:YES];
    [window.contentView addSubview:labeledProgressView];
    [[scrollview animator] setFrameOrigin:NSMakePoint(0,200)];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.005
                                             target:self
                                           selector:@selector(spin_circle)
                                           userInfo:nil
                                            repeats:YES];
    [brands_turbo collected_brands:@"update"];
    
}

-(void)update_end:(NSNotification *)notification{
    NSLog(@"%@",@"end");
    [public_info setProgress:0];
    [public_info setTopIsUpdting:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [labeledProgressView removeFromSuperview];
        [[scrollview animator] setFrameOrigin:NSMakePoint(0, 0)];
    });
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"load_image" object:self];
    [timer invalidate];
    timer = nil;
}

- (void)spin_circle{
    CGFloat progress = [public_info progress] + 0.01f;
    [public_info setProgress:progress];
    [labeledProgressView setProgress:progress animated:YES];
    if ([public_info progress] >= 1.0f && [self.timer isValid]) {
        [public_info setProgress:0];
        [labeledProgressView setProgress:[public_info progress] animated:YES];
    }
}


- (void) adjust_traffic_light{
    NSView * themeframeview =[window.contentView superview];
    NSArray * get_containerview = themeframeview.subviews;
    if ([[get_containerview objectAtIndex:0] subviews].count>0){
        NSArray * get_scrollerview = [[get_containerview objectAtIndex:0] subviews];
        NSScrollView* myscrollview =  [get_scrollerview objectAtIndex:1];
        [myscrollview setFrame:window.contentView.frame];
    }
    
    NSView * titleBarContainerView = [get_containerview objectAtIndex:1];
    NSArray * get_titlebarview = titleBarContainerView.subviews;
    titleBarView = [get_titlebarview objectAtIndex:get_titlebarview.count-1];
    NSArray * get_elements = titleBarView.subviews;
    
    [[get_elements objectAtIndex:0] setFrame:NSMakeRect(12, 11, 14, 16)];
    [[get_elements objectAtIndex:1] setFrame:NSMakeRect(32, 11, 14, 16)];
    [[get_elements objectAtIndex:2] setFrame:NSMakeRect(52, 11, 14, 16)];
    
}

- (void) add_sidebar_button{
    sidebar_button = [[NSButton alloc] initWithFrame:NSMakeRect(76, 4, 45, 28)];
    [sidebar_button setButtonType:NSButtonTypeMomentaryPushIn];
    [sidebar_button setBezelStyle:NSTexturedSquareBezelStyle];
    [sidebar_button setBordered:YES];
    NSImage *sidebar_icon = [NSImage imageNamed:@"sidebar.png"];
    [sidebar_icon setSize:NSMakeSize(17, 17)];
    [sidebar_button setImage:sidebar_icon];
    [sidebar_button setAction:@selector(sidebar_Clicked)];
    [titleBarView addSubview:sidebar_button];
}

- (void) add_back_button{
    back_button = [[NSButton alloc] initWithFrame:NSMakeRect(126, 4, 45, 28)];
    [back_button setButtonType:NSButtonTypeMomentaryPushIn];
    [back_button setBezelStyle:NSTexturedSquareBezelStyle];
    [back_button setBordered:YES];
    NSImage *back_icon = [NSImage imageNamed:@"back.png"];
    [back_icon setSize:NSMakeSize(17, 17)];
    [back_button setImage:back_icon];
    [back_button setAction:@selector(back_Clicked)];
    [titleBarView addSubview:back_button];
}



-(void) back_Clicked{
    [sidebar_button setEnabled:YES];
    [back_button removeFromSuperview];
    [fanzhuan_view removeFromSuperview];
    [scrollView_2nd removeFromSuperview];
    [scrollview setFrame:window.contentView.frame];
}

-(void) scrollEnd:(NSNotification* )notification{
    if(![public_info ImageIsLoading]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"load_image" object:self];
    }
}

- (void) window_resize:(NSNotification *)notification{
    [self adjust_traffic_light];
}
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}






















// mouse click
-(void) enter_2nd_page:(id)sender{
    if (mytableview.numberOfRows>1) {
        [self add_back_button];
        [sidebar_button setEnabled:NO];
        int appheight = [[NSScreen mainScreen] frame].size.height;

        NSInteger rowIndex = [sender selectedRow];
        fanzhuan_view = [[fliped_view alloc] initWithFrame:NSMakeRect(0, 0, 420, appheight)];
        CATransition *transition = [CATransition animation];
        [transition setType:kCATransitionMoveIn];
        [transition setSubtype:kCATransitionFromRight];
        transition.duration=0.2;
        [[window.contentView layer] addAnimation:transition forKey:kCATransitionMoveIn];
        [scrollview setFrame:NSMakeRect(-500, 0, 420, 800)];
        [window.contentView addSubview:fanzhuan_view];
        
        // get news contents and height
        NSInteger index_news = (rowIndex-1)/2;
        NSString* news_title = [[[public_info news_list] objectAtIndex:index_news] objectForKey:@"title"];
//        NSMutableArray* news_content_array = [[[public_info news_list] objectAtIndex:index_news] objectForKey:@"news_contents"];
        NSTextField *temp_title_text = [[NSTextField alloc] initWithFrame:NSMakeRect(30,70,360,80)];
    
        [temp_title_text setWantsLayer:YES];
        [temp_title_text setStringValue:news_title];
         [temp_title_text setDrawsBackground:NO];
         [temp_title_text setFont:[NSFont fontWithName:@"STHeiti" size:20]];
         [temp_title_text setBackgroundColor:[NSColor clearColor]];
         [temp_title_text setEditable:NO];
         [temp_title_text setBordered:NO];
        NSLog(@"%@", news_title);
        NSLog(@"%@", temp_title_text);
        
        
        [fanzhuan_view addSubview:temp_title_text];
        
        
//        float total_height = 0;
//        for (int i=0; i<news_content_array.count; i++) {
//            NSString* unidentified_news_content = [news_content_array objectAtIndex:i];
//            if ([unidentified_news_content rangeOfString:@"http"].location!= NSNotFound){
//                NSURL *get_url =[[NSURL alloc] initWithString:unidentified_news_content];
//                NSImage *Image =[[NSImage alloc] initWithContentsOfURL:get_url];
//                total_height = total_height+Image.size.height;
//            }
//            if ([unidentified_news_content rangeOfString:@"http"].location == NSNotFound){
//                total_height = total_height + [self findHeightForText:unidentified_news_content
//                                                          havingWidth:360 andFont:[NSFont fontWithName:@"Arial" size:20]];
//            }
//            total_height = total_height + 10;
//        }
        
//        // create scrollview
//        scrollView_2nd = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 0, 420, 900)];
//        [fanzhuan_view addSubview: scrollView_2nd];
//        fliped_view* document_view = [[fliped_view alloc] initWithFrame:NSMakeRect(0, 0, 420, total_height)];
//        [scrollView_2nd setDocumentView:document_view];

//        NSTextField* temp_text = [[NSTextField alloc] initWithFrame:NSMakeRect(30, 100, 360, 50)];
//        [temp_text setStringValue:@"temporal purpose"];
//        [temp_text setFont:[NSFont fontWithName:@"Arial" size:20]];
//        [document_view addSubview:temp_text];
//        [temp_text setEditable:NO];
//        [temp_text setBordered:NO];

        //        float height_above = 100;
        //        for (int i=0; i<news_content_array.count; i++) {
        //            NSString* unidentified_news_content = [news_content_array objectAtIndex:i];
        //            if ([unidentified_news_content rangeOfString:@"http"].location!= NSNotFound){
        //                NSURL *get_url =[[NSURL alloc] initWithString:unidentified_news_content];
        //                NSImage *Image =[[NSImage alloc] initWithContentsOfURL:get_url];
        //                NSImageView* temp_imageview = [[NSImageView alloc] initWithFrame:NSMakeRect(30, height_above, 360, Image.size.height)];
        //                [temp_imageview setImage:Image];
        //                [document_view addSubview:temp_imageview];
        //                height_above = height_above+Image.size.height+10;
        //            }
        //            if ([unidentified_news_content rangeOfString:@"http"].location == NSNotFound){
        //            }
        //            [scrollView_2nd setHasVerticalScroller:YES];
        //            [scrollView_2nd setHasHorizontalScroller:NO];
        //        }
    }
}


- (float)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(NSFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size.height;
}



@end
