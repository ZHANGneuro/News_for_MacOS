//
//  renminwang_lobby.m
//  NewsRoom
//
//  Created by boo on 14/08/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "renminwang_lobby.h"

@implementation renminwang_lobby

static NSMutableArray *url_list = nil;

+(void)get:(NSString*)type{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://news.people.com.cn/GB/28053/index.html"]];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *webcode = [[NSString alloc] initWithData:data encoding:enc];
    NSString* parsed_code = [[parse_method alloc] get_string:webcode input_key_word_head:@"<table width=\"80%\"" input_key_word_end:@"</table>"];
    
    url_list = [[NSMutableArray alloc] init];
    url_list = [[parse_method alloc]
                get_multi_string:parsed_code
                input_key_word_head:@"href=\""
                input_key_word_end:@"\""];
    
    if(url_list.count==50){
        [self parse:type];
    }
}

+(void) parse:(NSString*)type{
    
    for (int i=0; i<url_list.count; i++){
        
        NSMutableDictionary* aNews =[[NSMutableDictionary alloc] init];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url_list objectAtIndex:i]]];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *ocode = [[NSString alloc] initWithData:data encoding:enc];
        NSString*parsed_code = [[parse_method alloc] get_string:ocode input_key_word_head:@"<!--text_title-->" input_key_word_end:@"<!--left-banner-->"];
        
        if(parsed_code){
            NSString* title = [[parse_method alloc] get_string:parsed_code input_key_word_head:@"<h1>" input_key_word_end:@"</h1>"];
            if([title containsString:@"&nbsp;"]){
                NSArray * title_split = [title componentsSeparatedByString:@"&nbsp;"];
                title = [title_split componentsJoinedByString:@" "];
            }
 
            NSString* postTime = [[parse_method alloc] get_string_for_time:parsed_code input_key_word_head:@"<div class=\"fl\">" input_key_word_end:@"&nbsp;"];
            
            NSString* coverImage = [[parse_method alloc] get_string:parsed_code input_key_word_head:@"<img alt=\"\" src=\"" input_key_word_end:@"\""];
            
            if(![[public_info Title_Loaded] containsObject:title]){
                [aNews setObject:ocode forKey:@"ocode"];
                [aNews setObject:@"人民网" forKey:@"brand"];
                [aNews setObject:@"renminwang" forKey:@"brand_pinyin"];
                [aNews setObject:[url_list objectAtIndex:i] forKey:@"newsUrl"];
                [aNews setObject:title forKey:@"title"];
                [aNews setObject:postTime forKey:@"postTime"];
                if(!coverImage){
                    [aNews setValue:@"null" forKey:@"coverImage"];
                    [aNews setObject:@"null" forKey:@"coverImageUrl"];
                }
            }
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
            [[public_info Title_Loaded] addObject:title];
        }
    }
}



@end
