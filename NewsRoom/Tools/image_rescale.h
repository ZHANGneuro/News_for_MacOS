//
//  image_rescale.h
//  news2
//
//  Created by boo on 16/5/14.
//  Copyright © 2016年 boo. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface image_rescale : NSObject

-(NSImage *)image_url:(NSString *)image_url image_width:(float)image_width image_height:(float) image_height;


@end
