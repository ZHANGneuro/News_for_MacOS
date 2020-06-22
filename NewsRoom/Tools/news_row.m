//
//  news_row.m
//  Galance
//
//  Created by boo on 01/02/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "news_row.h"

@implementation news_row


- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setWantsLayer:YES];
        [self setCanDrawSubviewsIntoLayer:YES];
        [self setCanDrawConcurrently:YES];
        
        _title_text = [[NSTextField alloc] init];
        [_title_text setWantsLayer:YES];
        [_title_text setCanDrawSubviewsIntoLayer:YES];
        [_title_text setCanDrawConcurrently:YES];
        [_title_text setDrawsBackground:NO];
        [_title_text setFont:[NSFont fontWithName:@"STHeiti" size:17]];
        [_title_text setBackgroundColor:[NSColor clearColor]];
        [_title_text setEditable:NO];
        [_title_text setBordered:NO];
        
        _brand_text = [[NSTextField alloc] init];
        [_brand_text setWantsLayer:YES];
        [_brand_text setCanDrawSubviewsIntoLayer:YES];
        [_brand_text setDrawsBackground:NO];
        [_brand_text setCanDrawConcurrently:YES];
        [_brand_text setFont:[NSFont fontWithName:@"STHeiti" size:15]];
        [_brand_text setBackgroundColor:[NSColor clearColor]];
        [_brand_text setTextColor:[NSColor colorWithCalibratedRed:(121/255.0f) green:(120/255.0f) blue:(121/255.0f) alpha:1.0]];
        [_brand_text setEditable:NO];
        [_brand_text setBordered:NO];
        [_brand_text setAlignment:NSTextAlignmentLeft];
        
        _date_text = [[NSTextField alloc] init];
        [_date_text setWantsLayer:YES];
        [_date_text setCanDrawSubviewsIntoLayer:YES];
        [_date_text setDrawsBackground:NO];
        [_date_text setCanDrawConcurrently:YES];
        [_date_text setFont:[NSFont fontWithName:@"STHeiti" size:15]];
        [_date_text setBackgroundColor:[NSColor clearColor]];
        [_date_text setTextColor:[NSColor colorWithCalibratedRed:(121/255.0f) green:(120/255.0f) blue:(121/255.0f) alpha:1.0]];
        [_date_text setEditable:NO];
        [_date_text setBordered:NO];
        [_date_text setAlignment:NSTextAlignmentLeft];
        
        _imageview = [[NSImageView alloc] initWithFrame:NSMakeRect([public_info window_width]-[public_info scroller_width]-[public_info space_width]-[public_info Table_image_width], 0, [public_info Table_image_width], [public_info row_height])];
        [_imageview setCanDrawSubviewsIntoLayer:YES];
        [_imageview setCanDrawConcurrently:YES];
        [_imageview setImageFrameStyle:NSImageFrameNone];
        
        [self addSubview:_title_text];
        [self addSubview:_imageview];
        [self addSubview:_brand_text];
        [self addSubview:_date_text];
    }
    
    return self;
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self wantsDefaultClipping];
}

-(BOOL) wantsDefaultClipping {
    return NO;
}
@end




