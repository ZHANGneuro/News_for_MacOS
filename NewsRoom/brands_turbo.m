//
//  brands_turbo.m
//  NewsRoom
//
//  Created by boo on 17/08/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "brands_turbo.h"

@implementation brands_turbo


+(void)collected_brands: (NSString*) type{
    
    [public_info setPush_counter:0];
    
    NSInteger wangyiStatus = 0; //[[NSUserDefaults standardUserDefaults] integerForKey:@"wangyi"];
    //        NSInteger renminwangStatus = 0; //[[NSUserDefaults standardUserDefaults] integerForKey:@"renminwang"];
    
    if([type isEqual:@"startup"]){
        if (wangyiStatus==1) {
            [wangyi_lobby get:type];
        }
    }
    if([type isEqual:@"update"]){
        [wangyi_lobby get:type];
    }
    
    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//
//    });
    
}


@end
