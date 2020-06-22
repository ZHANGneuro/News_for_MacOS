//
//  parse_method.h
//  news2
//
//  Created by boo on 2016/10/3.
//  Copyright © 2016年 boo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parse_method : NSObject

@property  NSString *raw_web_content;
@property  NSString *key_word_head;
@property  NSString *key_word_end;
@property  NSMutableArray *export_array;
@property  NSString *key_word_head1;
@property  NSString *key_word_head2;
@property  NSString *key_word_end1;
@property  NSString *key_word_end2;

@property NSString *image_head;
@property NSString *image_end;

@property NSMutableArray *imagetext_array;
@property NSMutableArray *num_array;


-(NSString* )get_string:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end;

-(NSString* )get_string_for_time:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end;

-(NSMutableArray* )get_multi_string:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end;

-(NSMutableArray* )get_multi_string_for_time:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end;

-(NSString* )time_parser:(NSString *)time_string separate_symbol:(NSString *)separate_symbol;

-(NSMutableArray* )get_multi_string_multi_keyword:(NSString *)input_web_content input_key_word_head1:(NSString *)input_key_word_head1 input_key_word_head2:(NSString *)input_key_word_head2 input_key_word_end1:(NSString *)input_key_word_end1 input_key_word_end2:(NSString *)input_key_word_end2;

-(NSMutableArray* )get_multiple_text_image:(NSString *)code image_head:(NSString *)a image_end:(NSString *)b key_word_head1:(NSString *)c key_word_end1:(NSString *)d text_head2:(NSString *)e text_end2:(NSString *)f;



@end
