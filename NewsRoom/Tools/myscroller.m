//
//  myscroller.m
//  Galance
//
//  Created by boo on 27/01/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "myscroller.h"

@implementation myscroller


- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame:frameRect];
    if (self == nil) {
        return nil;
    }
    return self;
}


- (void)setFloatValue:(float)aFloat
{
    [super setFloatValue:aFloat];
//    [self.animator setAlphaValue:1.0f];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOut) object:nil];
//    [self performSelector:@selector(fadeOut) withObject:nil afterDelay:0.2f];
}

//- (void)fadeOut
//{
//    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
//        context.duration = 0.1f;
//        [self.animator setAlphaValue:0.0f];
//    } completionHandler:^{
//    }];
//}

- (void)drawKnobSlotInRect:(NSRect)slotRect highlight:(BOOL)flag{
}


@end
