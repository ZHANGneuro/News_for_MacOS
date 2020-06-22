//
//  wangyi_lobby.h
//  news2
//
//  Created by boo on 16/11/2016.
//  Copyright © 2016 boo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "parse_method.h"
#import "public_info.h"
#import "push.h"

@interface wangyi_lobby : NSObject

+(void) get:(NSString*)type;
+(void) parse:(NSString*)type;



@end
