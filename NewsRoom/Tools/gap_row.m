//
//  gap_row.m
//  Galance
//
//  Created by boo on 30/01/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "gap_row.h"

@implementation gap_row

- (id)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    [self setWantsLayer:YES];
    [self setCanDrawSubviewsIntoLayer:YES];
    [self setCanDrawConcurrently:YES];
    return self;
}


- (void)drawRect:(NSRect)dirtyRect{
    [self wantsDefaultClipping];
    NSBezierPath *line = [NSBezierPath bezierPath];
    [line moveToPoint:NSMakePoint([public_info space_width], [public_info tinyRow_height]/2)];
    [line lineToPoint:NSMakePoint([public_info window_width]-[public_info scroller_width]-[public_info space_width], [public_info tinyRow_height]/2)];
    [line setLineWidth:1.0];
    NSColor *lineColor=[NSColor colorWithCalibratedRed:(234/255.0f) green:(234/255.0f) blue:(234/255.0f) alpha:1.0f];
    [lineColor set];
    [line stroke];
}


-(BOOL) wantsDefaultClipping {
    return NO;
}

@end
