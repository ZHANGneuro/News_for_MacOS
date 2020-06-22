//
//  wangyi_lobby.m
//  news2
//
//  Created by boo on 16/11/2016.
//  Copyright © 2016 boo. All rights reserved.
//

#import "wangyi_lobby.h"

@implementation wangyi_lobby
static NSMutableArray *url_list = nil;
static NSMutableArray *title_list = nil;
static NSMutableArray *postTime_list = nil;
static NSMutableArray *imageUrl_list = nil;

+(void)get:(NSString*)type{
    
    for (int i=0; i<[public_info WangYi].count; i++) {
        if (!url_list | !title_list | !postTime_list | !imageUrl_list){
            url_list = [[NSMutableArray alloc] init];
            title_list = [[NSMutableArray alloc] init];
            postTime_list = [[NSMutableArray alloc] init];
            imageUrl_list = [[NSMutableArray alloc] init];
        }
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[public_info WangYi] objectAtIndex:i]]];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *json_string = [[NSString alloc] initWithData:data encoding:enc];
        NSMutableArray* url_list_segment = [[NSMutableArray alloc] init];
        NSMutableArray* title_list_segment = [[NSMutableArray alloc] init];
        NSMutableArray* postTime_list_segment = [[NSMutableArray alloc] init];
        NSMutableArray* imageUrl_list_segment = [[NSMutableArray alloc] init];
        url_list_segment = [[parse_method alloc]
                            get_multi_string:json_string
                            input_key_word_head:@"\"docurl\":\""
                            input_key_word_end:@"\","];
        title_list_segment = [[parse_method alloc]
                              get_multi_string:json_string
                              input_key_word_head:@"\"title\":\""
                              input_key_word_end:@"\","];
        postTime_list_segment = [[parse_method alloc]
                                 get_multi_string_for_time:json_string
                                 input_key_word_head:@"time\":\""
                                 input_key_word_end:@"\","];
        imageUrl_list_segment = [[parse_method alloc]
                                 get_multi_string:json_string
                                 input_key_word_head:@"imgurl\":\""
                                 input_key_word_end:@"\""];
        
        [url_list addObjectsFromArray:url_list_segment];
        [title_list addObjectsFromArray:title_list_segment];
        [postTime_list addObjectsFromArray:postTime_list_segment];
        [imageUrl_list addObjectsFromArray:imageUrl_list_segment];
    }
[self parse:type];
    
}


+(void) parse:(NSString*)type{
    
    for (int i=0; i<imageUrl_list.count; i++){
        dispatch_async(dispatch_queue_create("threads", DISPATCH_QUEUE_SERIAL),^{
            
            if(![[public_info Title_Loaded] containsObject:[title_list objectAtIndex:i]]){
                NSMutableDictionary* aNews =[[NSMutableDictionary alloc] init];
                NSURL *web_url = [NSURL URLWithString: [url_list objectAtIndex:i]];
                NSString* ocode = [NSString  stringWithContentsOfURL:web_url usedEncoding:nil error:nil];
                [aNews setObject:ocode forKey:@"ocode"];
                [aNews setObject:@"网易新闻" forKey:@"brand"];
                [aNews setObject:@"wangyi" forKey:@"brand_pinyin"];
                [aNews setObject:[url_list objectAtIndex:i] forKey:@"newsUrl"];
                [aNews setObject:[title_list objectAtIndex:i] forKey:@"title"];
                [aNews setObject:[postTime_list objectAtIndex:i] forKey:@"postTime"];
                [aNews setValue:nil forKey:@"coverImage"];
                [aNews setObject:[imageUrl_list objectAtIndex:i] forKey:@"coverImageUrl"];
                
                if([type isEqual:@"startup"]){
                    if([public_info Push_counter]<[public_info NumNewsPush]){
                        [[public_info news_list] insertObject:aNews atIndex:0];
                        [push push_news:type];
                    } else {
                        [[public_info news_list] addObject:aNews];
                    }
                }
                if([type isEqual:@"update"]){
                    [[public_info news_list] insertObject:aNews atIndex:0];
                    [push push_news:type];
                }
                [[public_info Title_Loaded] addObject:[title_list objectAtIndex:i]];
            }
        });
    }
    
    if ([public_info TopIsUpdting]){
        NSLog(@"%hhd", [public_info TopIsUpdting]);
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"update_end" object:self];
        });
        
    }
}



@end
