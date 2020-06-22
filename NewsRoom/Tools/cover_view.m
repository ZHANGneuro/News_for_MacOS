//
//  cover_view.m
//  Galance
//
//  Created by boo on 22/05/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "cover_view.h"

@implementation cover_view

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}
- (void)mouseDown:(NSEvent *)event{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"close_sidebar" object:self];

}



@end
