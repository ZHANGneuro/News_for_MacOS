//
//  image_rescale.m
//  news2
//
//  Created by boo on 16/5/14.
//  Copyright © 2016年 boo. All rights reserved.
//

#import "image_rescale.h"

@implementation image_rescale


-(NSImage *)image_url:(NSString *)image_url image_width:(float)image_width image_height:(float) image_height
{
    
    if(self && image_url!=nil){
        
        NSURL *get_url =[[NSURL alloc] initWithString:image_url];
        NSImage *Image =[[NSImage alloc] initWithContentsOfURL:get_url];
        CGImageRef CGImage = [Image CGImageForProposedRect:nil context:nil hints:nil];
        NSBitmapImageRep *bitImage = [[NSBitmapImageRep alloc] initWithCGImage:CGImage];
        
        CGRect rect = CGRectZero;
        float ratio_original=(float)bitImage.pixelsWide/(float)bitImage.pixelsHigh;
        float ratio_ontable = (float)image_width/(float)image_height;
        if (ratio_original<=ratio_ontable){
            rect = CGRectMake(0,(((float)bitImage.pixelsHigh-(float)bitImage.pixelsWide*(float)image_height/(float)image_width)/2),(float)bitImage.pixelsWide, (float)(bitImage.pixelsWide*(float)image_height/(float)image_width));
        }
        if(ratio_original>ratio_ontable){
            rect = CGRectMake((((float)bitImage.pixelsWide-(float)bitImage.pixelsHigh*(float)image_width/(float)image_height)/2), 0,((float)bitImage.pixelsHigh*(float)image_width/(float)image_height),(float)bitImage.pixelsHigh);
        }
        CGImageRef imageRef = CGImageCreateWithImageInRect(CGImage,rect);
        NSImage *croppedimage = [[NSImage alloc] initWithCGImage:imageRef size: NSZeroSize];
        NSSize size;
        size.height =  image_height;
        size.width = image_width;
        [croppedimage setSize:size];
        CGImageRelease(imageRef);
        return croppedimage;
    }
    return nil;
}




@end
