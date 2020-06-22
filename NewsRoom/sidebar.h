//
//  sidebar.h
//  Galance
//
//  Created by boo on 17/02/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "public_info.h"
#import "CenCheckBox.h"
#import "renminwang_lobby.h"

@interface sidebar : NSScrollView <NSOutlineViewDelegate,NSOutlineViewDataSource,NSTableViewDataSource,NSTableViewDelegate>

@property NSUserDefaults* wangyi;
@property NSUserDefaults* renminwang;



@end
