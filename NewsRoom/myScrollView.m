//
//  myScrollView.m
//  news2
//
//  Created by boo on 15/12/13.
//  Copyright © 2015年 boo. All rights reserved.
//

#import "myScrollView.h"

@implementation myScrollView

- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self) {
        [self setWantsLayer:YES];
        [self.contentView setWantsLayer:YES];
        [self setDrawsBackground:NO];
        [self setCanDrawConcurrently:YES];
    }
    return self;
}


- (void)scrollWheel:(NSEvent *)theEvent{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bottom_checking" object:self];
    if ([public_info TopIsUpdting]) return;
    if (theEvent.phase == NSEventPhaseEnded) {
        if ([public_info TopIsUpdting]==NO && [self isOverHeadView] && [public_info news_list].count>0) {
            NSLog(@"%@", @"updating start");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"update_start" object:self];
        }
    }
    [super scrollWheel:theEvent];
}


- (BOOL)isOverHeadView{
    NSClipView *clipView = [self contentView];
    CGFloat scrolledY = clipView.bounds.origin.y;
    return scrolledY <= -20;
}








@end
