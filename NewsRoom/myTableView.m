//
//  myTableView.m
//  news2
//
//  Created by boo on 15/12/19.
//  Copyright © 2015年 boo. All rights reserved.


#import "myTableView.h"

@implementation myTableView
@synthesize timeStart;

- (id)initWithFrame:(NSRect)frameRect{
    self = [super initWithFrame: frameRect];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(top_add_row:) name:@"top_add_row" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottom_add_row:) name:@"bottom_add_row" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(load_image:) name:@"load_image" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bottom_checking:) name:@"bottom_checking" object:nil];
        
        NSTableColumn* tCol = [[NSTableColumn alloc] initWithIdentifier:@"tablecolumn"];
        [tCol setWidth:[public_info window_width]];
        [self addTableColumn:tCol];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setGridStyleMask:NSTableViewGridNone];
        [self setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
        [self setHeaderView:nil];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setTarget:nil];
        [self setIntercellSpacing:NSMakeSize(0, 0)];
        [self setWantsLayer:YES];
        [self setCanDrawConcurrently:YES];
        return self;
    }
    return nil;
}




-(NSView *) tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    if ([[tableColumn identifier] isEqual:@"tablecolumn"]){
        if (row%2==0){
            static NSString *cellIdentifier = @"gap";
            gap_row* sub_row = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
            if (sub_row == nil){
                sub_row = [[gap_row alloc] initWithFrame:NSMakeRect([public_info space_width], 0, [public_info window_width], [public_info row_height])];
                [sub_row setIdentifier:cellIdentifier];
            }
            return sub_row;
        }
        if (row%2==1){
            static NSString *cellIdentifier = @"newsRow";
            news_row* back_row = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
            if (back_row == nil){
                back_row = [[news_row alloc] initWithFrame:NSMakeRect(0, 0, [public_info window_width], [public_info row_height])];
                [back_row setIdentifier:cellIdentifier];
            }
            @try {
                float width_for_title;
                NSString* postdate = [[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"postTime"];
                NSString* brand = [[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"brand"];
                NSImage* temp_ima = [[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"coverImage"];
                
                // load image
                if([temp_ima isEqual:@"null"]){
                    [back_row.imageview setImage:nil];
                    width_for_title = [public_info window_width]-[public_info scroller_width]-[public_info space_width]*2;
                } else {
                    [back_row.imageview setImage:[[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"coverImage"]];
                    [back_row.imageview setWantsLayer:YES];
                    [back_row.imageview.layer addAnimation:[self fade_effect] forKey:nil];
                    width_for_title = [public_info window_width]-[public_info scroller_width]-[public_info Table_image_width]-[public_info space_width]*2;
                }
                // load title & data
                if(![postdate isEqual:@"dateForBottomRow"]){
                    [back_row.title_text setFrame:NSMakeRect([public_info space_width], 0, width_for_title, [public_info row_height])];
                    [back_row.title_text setAlignment:NSTextAlignmentLeft];
                } else{
                    postdate = @" ";
                    brand = @" ";
                    [back_row.title_text setFrame:NSMakeRect(0,35, [public_info window_width], [public_info row_height])];
                    [back_row.title_text setAlignment:NSTextAlignmentCenter];
                }
                
                [back_row.title_text setStringValue:[[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"title"]];
                //                NSLog(@"%@", [[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"title"]);
                [back_row.brand_text setStringValue:brand];
                [back_row.date_text setStringValue:postdate];
                
                CGFloat title_height = [((NSTextFieldCell *)[back_row.title_text cell]) cellSizeForBounds:NSMakeRect(0, 0, width_for_title, FLT_MAX)].height;
                [back_row.brand_text setFrame:NSMakeRect([public_info space_width], title_height+5, width_for_title, 18)];
                [back_row.date_text setFrame:NSMakeRect([public_info space_width], 10 + 18 + title_height, width_for_title, 18)];
                
            } @catch (NSException *exception) {
//                NSLog(@"title %@",[[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"title"]);
//                NSLog(@"brand %@",[[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"brand"]);
//                NSLog(@"time %@",[[[public_info news_list] objectAtIndex:(row-1)/2] objectForKey:@"postTime"]);
            }
            return back_row;
        }
    }
    return nil;
}



-(void)load_image:(NSNotification *)notification{
    [public_info setImageIsLoading:YES];
    dispatch_group_t group = dispatch_group_create();
    //    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect visibleRect = [self superview].visibleRect;
        NSRange rowinrect = [self rowsInRect:visibleRect];
        int loca = (int)rowinrect.location+1;
        int leng = (int)rowinrect.length;
        for (int i=loca; i<loca+leng; i++){
            
            dispatch_async(dispatch_queue_create("threads", DISPATCH_QUEUE_SERIAL),^{
                int index = i/2-1;
                if (i%2==0 && [[[public_info news_list] objectAtIndex:index] objectForKey:@"coverImage"] == nil){
                    NSString* imageURL = [[[public_info news_list] objectAtIndex:index] objectForKey:@"coverImageUrl"];
                    if(![imageURL isEqual:@"null"]){
                        NSImage* croppedimage = [[image_rescale alloc] image_url:imageURL image_width:[public_info Table_image_width] image_height:[public_info row_height]];
                        [[[public_info news_list] objectAtIndex:index] setValue:croppedimage forKey:@"coverImage"];
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self beginUpdates];
                    [self reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:i-1] columnIndexes:[NSIndexSet indexSetWithIndex:0]];
                    [self reloadData];
                    [self endUpdates];
                });
            });
        }
    });
    dispatch_group_notify(group, dispatch_get_main_queue(),^{
        [public_info setcheckbox_enabled:YES];
        [public_info setImageIsLoading:NO];
        
        //        NSLog(@"available_news  %d",[public_info available_news]);
        //        NSLog(@"num_failedNews  %d",[public_info num_failedNews]);
        //        NSLog(@"rowNum_tableview  %d",[public_info rowNum_tableview]);
    });
}





-(void)bottom_checking:(NSNotification *)notification{
    
    [public_info setRowNum_tableview:(int)(self.numberOfRows-1)/2];
    [public_info setAvailable_news:(int)[public_info news_list].count - [public_info num_failedNews] - [public_info rowNum_tableview]];
    if(![public_info BottomIsLoading] && ![public_info ReachBottom]){
        NSClipView *clipView = [self enclosingScrollView].contentView;
        float scrolled_Y = clipView.bounds.origin.y+clipView.bounds.size.height;
        int available_news = [public_info available_news];
        int rowNum_tableview = [public_info rowNum_tableview];
//        NSLog(@"rowNum_tableview  %d",[public_info rowNum_tableview]);
//        NSLog(@"available_news  %d",available_news);
        if (available_news>0 && rowNum_tableview>1 && scrolled_Y>=self.frame.size.height){
            [public_info setBottomIsLoading:YES];
            if(available_news>[public_info NumNewsPush]){
                [public_info setNumNewsPush:10];
            }
            if(available_news<=[public_info NumNewsPush]){
                [public_info setNumNewsPush:available_news];
            }
            [public_info setPush_counter:0];
            [push push_news:@"bottom"];
        }
        if((available_news==0) && [public_info news_list].count!=0){
            [public_info setReachBottom:YES];
            [public_info setBottomIsLoading:NO];
            NSMutableDictionary* aNews =[[NSMutableDictionary alloc] init];
            [aNews setObject: @"到底了 :)" forKey:@"title"];
            [aNews setObject: @"dateForBottomRow" forKey:@"postTime"];
            [[public_info news_list] addObject:aNews];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bottom_add_row" object:self];
        }
    }
}


-(void)top_add_row:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginUpdates];
        [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withAnimation:NSTableViewAnimationEffectFade];
        [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:0] withAnimation:NSTableViewAnimationEffectFade];
        [self endUpdates];
    });
}
-(void)bottom_add_row:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginUpdates];
        [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:(int)self.numberOfRows] withAnimation:NSTableViewAnimationEffectFade];
        [self insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:(int)self.numberOfRows] withAnimation:NSTableViewAnimationEffectFade];
        [self endUpdates];
    });
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)myTableView{
    return [[public_info news_list] count]*2+1;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    if (row%2==0){
        return [public_info tinyRow_height];
    }
    if (row%2==1){
        return [public_info row_height];
    }
    return 0;
}

- (CATransition *)fade_effect{
    CATransition *transition = [CATransition animation];
    [transition setType:kCATransitionFromLeft];
    [transition setSubtype:kCATransitionFade];
    transition.duration=0.1;
    return transition;
}











@end
