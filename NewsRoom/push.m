//
//  push.m
//  NewsRoom
//
//  Created by boo on 14/08/2017.
//  Copyright © 2017 boo. All rights reserved.
//



#import "push.h"

@implementation push

+(void)push_news:(NSString* )type{
    if([type isEqualTo:@"startup"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"top_add_row" object:self];
        [public_info setPush_counter:[public_info Push_counter]+1];
        if([public_info Push_counter]==[public_info NumNewsPush]){
            [self push_end:type];
            [public_info setIsStartup:NO];
        }
    }
    if([type isEqualTo:@"update"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"top_add_row" object:self];
    }
    if([type isEqualTo:@"bottom"]){
        for (int i=0; i<[public_info NumNewsPush]; i++) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bottom_add_row" object:self];
            [public_info setPush_counter:[public_info Push_counter]+1];
        }
        if([public_info Push_counter]==[public_info NumNewsPush]){
            [self push_end:type];
        }
    }
}

+ (void) push_end: (NSString *) type{
    if([type isEqualToString:@"startup"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"load_image" object:self];
        [public_info setReachBottom:NO];
    }
    if([type isEqualToString:@"bottom"]){
        [public_info setBottomIsLoading:NO];
        [public_info setReachBottom:NO];
    }
}










@end
