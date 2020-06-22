//
//  sidebar.m
//  Galance
//
//  Created by boo on 17/02/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "sidebar.h"

@implementation sidebar
@synthesize wangyi,renminwang;

- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame: frameRect];
    if (self) {
        [public_info logo_image_name];
        [public_info logo_name_pool];
        wangyi = [NSUserDefaults standardUserDefaults];
        renminwang = [NSUserDefaults standardUserDefaults];
        NSTableView * sidebar_tableview = [[NSTableView alloc] initWithFrame:frameRect];
        NSTableColumn* tCol = [[NSTableColumn alloc] initWithIdentifier:@"tablecolumn"];
        [tCol setWidth:frameRect.size.width];
        [sidebar_tableview addTableColumn:tCol];
        [sidebar_tableview setDelegate:self];
        [sidebar_tableview setDataSource:self];
        [sidebar_tableview setGridStyleMask:NSTableViewGridNone];
        [sidebar_tableview setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
        [sidebar_tableview setHeaderView:nil];
        [sidebar_tableview setBackgroundColor:[NSColor clearColor]];
        [sidebar_tableview setTarget:nil];
        [sidebar_tableview setIntercellSpacing:NSMakeSize(0, 0)];
        [sidebar_tableview setWantsLayer:YES];
        [sidebar_tableview setCanDrawConcurrently:YES];
        [self setDocumentView:sidebar_tableview];
        [self setDrawsBackground:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkbox_checked) name:@"checkbox_checked" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkbox_unchecked) name:@"checkbox_unchecked" object:nil];
        return self;
    }
    return nil;
}


-(NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    if (row%2==0){
        static NSString *cellIdentifier = @"newsRow";
        NSView* back_row = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
        if (back_row == nil){
            back_row = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, [public_info sidebarWidth], 150)];
            [back_row setIdentifier:cellIdentifier];
        }
        return back_row;
    }
    if (row%2==1){
        static NSString *cellIdentifier = @"newsRow";
        NSView* back_row = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
        if (back_row == nil){
            back_row = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, [public_info sidebarWidth], 150)];
            [back_row setIdentifier:cellIdentifier];
        }
        
        NSImage* logo_image = [NSImage imageNamed:[[public_info logo_image_name] objectAtIndex:(row-1)/2]];
        float width_of_logo = logo_image.size.width*[public_info sidebarRowHeight]/logo_image.size.height;
        float height_of_logo = [public_info sidebarRowHeight];
        NSImageView *logo_view = [[NSImageView alloc] initWithFrame:NSMakeRect(1.5*[public_info sidebarWidth]/20, 0, width_of_logo, height_of_logo)];
        [logo_image setSize:NSMakeSize(width_of_logo,height_of_logo)];
        [logo_view setImage:logo_image];
        [logo_view setCanDrawSubviewsIntoLayer:YES];
        [logo_view setCanDrawConcurrently:YES];
        [logo_view setImageFrameStyle:NSImageFrameNone];
        [back_row addSubview:logo_view];
        
        [public_info setlogo_identifier:[[public_info logo_name_pool] objectAtIndex:(row-1)/2]];
        CenCheckBox* checkbox = [[CenCheckBox alloc] initWithFrame:NSMakeRect(1.5*[public_info sidebarWidth]/20+width_of_logo+10, (height_of_logo-35)/2, 35, 35)];
        checkbox.animator = @"BEMAnimationTypeFill";
        [checkbox setAction:@selector(mouseDown:)];
        [back_row addSubview:checkbox];
        return back_row;
    }
    return nil;
}


-(NSInteger)numberOfRowsInTableView:(NSTableView *)myTableView{
    return [public_info logo_image_name].count *2;
}


- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    if (row%2==0){
        return 30;
    }
    if (row%2==1){
        return [public_info sidebarRowHeight];
    }
    return 0;
}



- (void) checkbox_unchecked{
    if ([[public_info logo_clicked] isEqual:@"wangyi"]) {
        [wangyi setInteger:0 forKey:@"wangyi"];
        [public_info setReachBottom:NO];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"remove_row" object:self];
    }
//    if ([[public_info logo_clicked] isEqual:@"renminwang"]) {
//        [renminwang setInteger:0 forKey:@"renminwang"];
//        [public_info setReachBottom:NO];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"remove_row" object:self];
//    }
}

- (void) checkbox_checked{
    if ([[public_info logo_clicked] isEqual:@"wangyi"]) {
        [wangyi setInteger:1 forKey:@"wangyi"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"add_row" object:self];
    
    }
//    if ([[public_info logo_clicked] isEqual:@"renminwang"]) {
//        [renminwang setInteger:1 forKey:@"renminwang"];
//        [renminwang_lobby get:@"startup"];
//    }
}


@end
