//
//  news_row.h
//  Galance
//
//  Created by boo on 01/02/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "public_info.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>
#import <QuartzCore/CAGradientLayer.h>

@interface news_row : NSTableRowView

@property NSTextField *title_text;

@property NSImageView *imageview;
@property NSTextField *brand_text;
@property NSTextField *date_text;
@end
