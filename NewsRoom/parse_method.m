//
//  parse_method.m
//  news2
//
//  Created by boo on 2016/10/3.
//  Copyright © 2016年 boo. All rights reserved.
//

#import "parse_method.h"

@implementation parse_method
@synthesize raw_web_content,key_word_head,key_word_end,export_array,key_word_head1,key_word_head2,key_word_end1,key_word_end2,image_end,image_head,imagetext_array,num_array;


-(NSString* )get_string:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end{
    raw_web_content=input_web_content;
    key_word_head=input_key_word_head;
    key_word_end=input_key_word_end;
    NSRange target_front = [raw_web_content rangeOfString:key_word_head];
    if(target_front.length==0){
        return nil;
    }
    raw_web_content = [raw_web_content substringFromIndex:target_front.location+target_front.length];
    NSRange target_end = [raw_web_content rangeOfString:key_word_end];
    NSString *target = [raw_web_content substringToIndex:target_end.location];
    return target;
}


-(NSMutableArray* )get_multi_string:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end{
    raw_web_content=input_web_content;
    key_word_head=input_key_word_head;
    key_word_end=input_key_word_end;
    export_array = [[NSMutableArray alloc] init];
    int counter = 0;
    while ([raw_web_content rangeOfString:key_word_head].location != NSNotFound){
        NSRange target_front = [raw_web_content rangeOfString:key_word_head];
        raw_web_content = [raw_web_content substringFromIndex:target_front.location+target_front.length];
        NSRange target_end = [raw_web_content rangeOfString:key_word_end];
        NSString *target = [raw_web_content substringToIndex:target_end.location];
        if([target length]==0){
            [export_array insertObject:@"null" atIndex:counter];
        } else{
            [export_array insertObject:target atIndex:counter];
        }
        counter = counter+1;
    }
    return export_array;
}


-(NSString* )get_string_for_time:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end{
    raw_web_content=input_web_content;
    key_word_head=input_key_word_head;
    key_word_end=input_key_word_end;
    NSRange target_front = [raw_web_content rangeOfString:key_word_head];
    raw_web_content = [raw_web_content substringFromIndex:target_front.location+target_front.length];
    NSRange target_end = [raw_web_content rangeOfString:key_word_end];
    NSString *target = [raw_web_content substringToIndex:target_end.location];
    NSString* printed_time = [self time_parser:target separate_symbol:@"年月日"];
    return printed_time;
}



-(NSMutableArray* )get_multi_string_for_time:(NSString *)input_web_content input_key_word_head:(NSString *)input_key_word_head input_key_word_end:(NSString *)input_key_word_end{
    raw_web_content=input_web_content;
    key_word_head=input_key_word_head;
    key_word_end=input_key_word_end;
    export_array = [[NSMutableArray alloc] init];
    int counter = 0;
    while ([raw_web_content rangeOfString:key_word_head].location != NSNotFound){
        NSRange target_front = [raw_web_content rangeOfString:key_word_head];
        raw_web_content = [raw_web_content substringFromIndex:target_front.location+target_front.length];
        NSRange target_end = [raw_web_content rangeOfString:key_word_end];
        NSString *target = [raw_web_content substringToIndex:target_end.location];
        NSString* printed_time = [self time_parser:target separate_symbol:@"/"];
        [export_array insertObject:printed_time atIndex:counter];
        counter = counter+1;
    }
    return export_array;
}


-(NSString* )time_parser:(NSString *)time_string separate_symbol:(NSString *)separate_symbol{
    if([separate_symbol  isEqual: @"/"]){
        NSArray *the_array = [time_string componentsSeparatedByString: @" "];
        NSArray *date_array = [[NSArray alloc] init];
        NSArray *time_array = [[NSArray alloc] init];
        NSString *date = [the_array objectAtIndex:0];
        NSString *time = [the_array objectAtIndex:1];
        date_array = [date componentsSeparatedByString: separate_symbol];
        time_array = [time componentsSeparatedByString: @":"];
        
        NSString* month = [date_array objectAtIndex:0];
        NSString* day = [date_array objectAtIndex:1];
        NSString* hour = [time_array objectAtIndex:0];
        NSString* minute = [time_array objectAtIndex:1];
        
//        NSNumber* month = [NSNumber numberWithInt:[[date_array objectAtIndex:0] intValue]];
//        NSNumber* day = [NSNumber numberWithInt:[[date_array objectAtIndex:1] intValue]];
//        NSNumber* hour = [NSNumber numberWithInt:[[time_array objectAtIndex:0] intValue]];
//        NSNumber* minute = [NSNumber numberWithInt:[[time_array objectAtIndex:1] intValue]];
        NSString* printed_time = [NSString stringWithFormat:@"%@-%@ %@:%@", month, day,hour,minute];
        return printed_time;
    }
    if([separate_symbol  isEqual: @"年月日"]){
        NSArray *date_array = [[NSArray alloc] init];
        date_array = [time_string componentsSeparatedByString: @"年"];
        NSString* segment = [date_array objectAtIndex:1];
        date_array = [segment componentsSeparatedByString: @"月"];
        NSString* month = [date_array objectAtIndex:0];
        segment = [date_array objectAtIndex:1];
        date_array = [segment componentsSeparatedByString: @"日"];
        NSString* day = [date_array objectAtIndex:0];
        NSString* min_sec = [date_array objectAtIndex:1];
        NSString* printed_time = [NSString stringWithFormat:@"%@-%@ %@", month, day, min_sec];
        return printed_time;
    }
    return nil;
}




-(NSMutableArray* )get_multi_string_multi_keyword:(NSString *)input_web_content input_key_word_head1:(NSString *)input_key_word_head1 input_key_word_head2:(NSString *)input_key_word_head2 input_key_word_end1:(NSString *)input_key_word_end1 input_key_word_end2:(NSString *)input_key_word_end2{
    raw_web_content=input_web_content;
    key_word_head1=input_key_word_head1;  // <p>
    key_word_end1=input_key_word_end1; // </p>
    key_word_head2=input_key_word_head1; // <strong>
    key_word_end2=input_key_word_end2; // </strong>
    export_array = [[NSMutableArray alloc] init];
    int counter = 0;
    while ([raw_web_content rangeOfString:key_word_head1].location != NSNotFound){
        NSRange target_front = [raw_web_content rangeOfString:key_word_head1];
        raw_web_content = [raw_web_content substringFromIndex:target_front.location+target_front.length];
        NSRange target_end = [raw_web_content rangeOfString:key_word_end1];
        NSString *target = [raw_web_content substringToIndex:target_end.location];
        if([target rangeOfString:@"<strong>"].location != NSNotFound){
            NSRange target_keyword1 = [target rangeOfString:@"<strong>"];
            target = [target substringFromIndex:target_keyword1.location+target_keyword1.length];
            NSRange target_keyword2 = [target rangeOfString:@"</strong>"];
            target = [target substringToIndex:target_keyword2.location];
        }
        [export_array insertObject:target atIndex:counter];
        counter = counter+1;
    }
    return export_array;
    
}

-(NSMutableArray* )get_multiple_text_image:(NSString *)code image_head:(NSString *)a image_end:(NSString *)b key_word_head1:(NSString *)c key_word_end1:(NSString *)d text_head2:(NSString *)e text_end2:(NSString *)f{
    raw_web_content=code;
    image_head=a;
    image_end=b;
    key_word_head1=c;
    key_word_end1=d;
    key_word_head2=e;
    key_word_end2=f;
    num_array = [[NSMutableArray alloc] init];
    int counter = 0;
    while ([raw_web_content rangeOfString:image_head].location != NSNotFound | [raw_web_content rangeOfString:key_word_head1].location != NSNotFound){
        
        NSRange image_key_front = [raw_web_content rangeOfString:image_head];
        NSRange text_key_front = [raw_web_content rangeOfString:key_word_head1];
        
        if (image_key_front.location<text_key_front.location) {
            raw_web_content = [raw_web_content substringFromIndex:image_key_front.location+image_key_front.length];
            NSRange image_key_end = [raw_web_content rangeOfString:image_end];
            NSString *image_target = [raw_web_content substringToIndex:image_key_end.location];
            [num_array insertObject:image_target atIndex:counter];
            counter = counter+1;
        }
        
        if(image_key_front.location>text_key_front.location){
            raw_web_content = [raw_web_content substringFromIndex:text_key_front.location+text_key_front.length];
            NSRange text_key_end = [raw_web_content rangeOfString:key_word_end1];
            NSString *text_target = [raw_web_content substringToIndex:text_key_end.location];
            [num_array insertObject:text_target atIndex:counter];
            counter = counter+1;
        }
    }
    return num_array;
}





@end
