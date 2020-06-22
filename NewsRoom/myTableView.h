//
//  myTableView.h
//  news2
//
//  Created by boo on 15/12/19.
//  Copyright © 2015年 boo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "public_info.h"
#import "image_rescale.h"
#import "gap_row.h"
#import "news_row.h"
#import "push.h"
#import "CenCheckBox.h"


@interface myTableView : NSTableView <NSTableViewDataSource,NSTableViewDelegate>


- (id)initWithFrame:(NSRect)frameRect;
@property NSDate *timeStart;


@end
