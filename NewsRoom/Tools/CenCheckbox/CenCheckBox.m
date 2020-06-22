//
//  CenCheckBox.m
//  CheckBox
//
//  Created by boo on 03/06/2017.
//  Copyright © 2017 boo. All rights reserved.
//

#import "CenCheckBox.h"

@interface CenCheckBox ()
@property (strong, nonatomic) CAShapeLayer *onBoxLayer;
@property (strong, nonatomic) CAShapeLayer *offBoxLayer;
@property (strong, nonatomic) CAShapeLayer *checkMarkLayer;
@property (strong, nonatomic) AnimationManager *animationManager;
@property (strong, nonatomic) PathManager *pathManager;
@property (strong, nonatomic) NSBezierPath *circle_map;
@end


@implementation CenCheckBox
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) [self commonInit];
    return self;
}


- (void)commonInit {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawCheckMark) name:@"drawCheckMark" object:nil];

    self.animator = @"BEMAnimationTypeBounce";
    self.local_logo = [public_info logo_identifier];
    NSInteger CheckStatus = 0; //[[NSUserDefaults standardUserDefaults] integerForKey:_local_logo];
    if (CheckStatus==1){
        self.checkboxStatus = YES;
    }else{
        self.checkboxStatus = NO;
    }
    
    self.blue_color = [NSColor colorWithRed:24.0/255.0 green:202.0/255.0 blue:255.0/255.0 alpha:1];
    self.offFillColor = [NSColor clearColor];
    self.tintColor = [NSColor lightGrayColor];
    self.lineWidth = 3;
    self.animationDuration = 0.3;
    self.pathManager = [PathManager new];
    self.circle_map = [_pathManager path_map:self.frame.size.width];
    self.animationManager = [[AnimationManager alloc] initWithAnimationDuration:_animationDuration];
}


- (void)mouseDown:(NSEvent *)theEvent{
    if ([public_info checkbox_enabled]) {
        NSPoint transformed_location = [self convertPoint: [theEvent locationInWindow] fromView: nil];
        BOOL inside_enclosed_area = [self.circle_map containsPoint:NSMakePoint(transformed_location.x, transformed_location.y)];
        if (inside_enclosed_area) {
            [public_info setcheckbox_enabled:NO];
            [public_info setlogo_clicked:_local_logo];
            [self setOn:!_checkboxStatus animated:YES];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    [self updateDraw];
}

- (void)setOn:(BOOL)status_input animated:(BOOL)animated {
    _checkboxStatus=status_input;
    if (_checkboxStatus) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkbox_checked" object:self];
        [self addOnAnimation];
        [self updateDraw];
    } else {
        [self addOffAnimation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkbox_unchecked" object:self];
        NSLog(@"%@",@"checkbox_unchecked");
        [self updateDraw];
    }
}

- (void)updateDraw {
    if (!self.offBoxLayer || CGRectGetHeight(CGPathGetBoundingBox(self.offBoxLayer.path)) == 0.0) {
        [self drawOffBox];
    } else {
        [self drawOnBox];
        [self drawCheckMark];
    }
}

- (void)addOnAnimation {
    if ([_animator isEqual: @"BEMAnimationTypeFlat"]) {
        CABasicAnimation *morphAnimation = [self.animationManager morphAnimationFromPath:[self.pathManager pathForFlatCheckMark] toPath:[self.pathManager pathForCheckMark]];
        CABasicAnimation *opacity = [self.animationManager opacityAnimationReverse:NO];
        opacity.duration = self.animationDuration / 5;
        
        [self.onBoxLayer addAnimation:opacity forKey:@"opacity"];
        [self.checkMarkLayer addAnimation:morphAnimation forKey:@"path"];
        [self.checkMarkLayer addAnimation:opacity forKey:@"opacity"];
    }
    if ([_animator isEqual: @"BEMAnimationTypeFill"]) {
        CAKeyframeAnimation *wiggle = [self.animationManager fillAnimationWithBounces:1 amplitude:0.18 reverse:NO];
        CABasicAnimation *opacityAnimation = [self.animationManager opacityAnimationReverse:NO];
        
        [self.onBoxLayer addAnimation:wiggle forKey:@"transform"];
        [self.checkMarkLayer addAnimation:opacityAnimation forKey:@"opacity"];
    }
    if ([_animator isEqual: @"BEMAnimationTypeStroke"]) {
        CABasicAnimation *animation = [self.animationManager strokeAnimationReverse:NO];
        [self.onBoxLayer addAnimation:animation forKey:@"strokeEnd"];
        [self.checkMarkLayer addAnimation:animation forKey:@"strokeEnd"];
    }
    if ([_animator isEqual: @"BEMAnimationTypeBounce"]) {
        CGFloat amplitude = 0.35;
        CAKeyframeAnimation *wiggle = [self.animationManager fillAnimationWithBounces:1 amplitude:amplitude reverse:NO];
        CABasicAnimation *opacity = [self.animationManager opacityAnimationReverse:NO];
        opacity.duration = self.animationDuration / 1.4;
        [self.onBoxLayer addAnimation:opacity forKey:@"opacity"];
        [self.checkMarkLayer addAnimation:wiggle forKey:@"transform"];
    }
}


- (void)addOffAnimation {
    if ([_animator isEqual: @"BEMAnimationTypeFlat"]) {
        CABasicAnimation *animation = [self.animationManager morphAnimationFromPath:[self.pathManager pathForCheckMark] toPath:[self.pathManager pathForFlatCheckMark]];
        CABasicAnimation *opacity = [self.animationManager opacityAnimationReverse:YES];
        opacity.duration = self.animationDuration;
        [self.onBoxLayer addAnimation:opacity forKey:@"opacity"];
        [self.checkMarkLayer addAnimation:animation forKey:@"path"];
        [self.checkMarkLayer addAnimation:opacity forKey:@"opacity"];
    }
    
    if ([_animator isEqual: @"BEMAnimationTypeFill"]) {
        CAKeyframeAnimation *wiggle = [self.animationManager fillAnimationWithBounces:1 amplitude:0.18 reverse:YES];
        wiggle.duration = self.animationDuration;
        [self.onBoxLayer addAnimation:wiggle forKey:@"transform"];
        [self.checkMarkLayer addAnimation:[self.animationManager opacityAnimationReverse:YES] forKey:@"opacity"];
    }
    
    if ([_animator isEqual: @"BEMAnimationTypeStroke"]) {
        CABasicAnimation *thisstroke = [self.animationManager strokeAnimationReverse:YES];
        CABasicAnimation *opacity = [self.animationManager opacityAnimationReverse:YES];
        opacity.duration = self.animationDuration+0.1f;
        [self.onBoxLayer addAnimation:thisstroke forKey:@"strokeEnd"];
        [self.checkMarkLayer addAnimation:thisstroke forKey:@"strokeEnd"];
        [self.checkMarkLayer addAnimation:opacity forKey:@"opacity"];
    }
    
    if ([_animator isEqual: @"BEMAnimationTypeBounce"]) {
        CGFloat amplitude = 0.35;
        CAKeyframeAnimation *wiggle = [self.animationManager fillAnimationWithBounces:1 amplitude:amplitude reverse:YES];
        wiggle.duration = self.animationDuration / 1.1;
        CABasicAnimation *opacity = [self.animationManager opacityAnimationReverse:YES];
        [self.onBoxLayer addAnimation:opacity forKey:@"opacity"];
        [self.checkMarkLayer addAnimation:wiggle forKey:@"transform"];
    }
}



- (void)drawOnBox {
    [self.onBoxLayer removeFromSuperlayer];
    self.onBoxLayer = [CAShapeLayer layer];
    self.onBoxLayer.frame = self.bounds;
    self.onBoxLayer.path = [self.pathManager pathForBox:self.frame.size.width];
    self.onBoxLayer.lineWidth = self.lineWidth;
    if ([_animator isEqual:@"BEMAnimationTypeStroke"]) {
        self.onBoxLayer.fillColor = [NSColor clearColor].CGColor;
    } else {
        self.onBoxLayer.fillColor = self.blue_color.CGColor;
    }
    self.onBoxLayer.strokeColor = self.blue_color.CGColor;
    self.onBoxLayer.rasterizationScale = 4;
    self.onBoxLayer.shouldRasterize = YES;
    [self setWantsLayer:YES];
    [self.layer addSublayer:self.onBoxLayer];
}

- (void)drawOffBox {
    [self.offBoxLayer removeFromSuperlayer];
    self.offBoxLayer = [CAShapeLayer layer];
    self.offBoxLayer.frame = self.bounds;
    self.offBoxLayer.path = [self.pathManager pathForBox:self.frame.size.width];
    self.offBoxLayer.fillColor = self.offFillColor.CGColor;
    self.offBoxLayer.strokeColor = self.tintColor.CGColor;
    self.offBoxLayer.lineWidth = self.lineWidth;
    self.onBoxLayer.rasterizationScale = 4;
    self.offBoxLayer.shouldRasterize = YES;
    [self setWantsLayer:YES];
    [self.layer addSublayer:self.offBoxLayer];
}

- (void)drawCheckMark {
    [self.checkMarkLayer removeFromSuperlayer];
    self.checkMarkLayer = [CAShapeLayer layer];
    self.checkMarkLayer.frame = self.bounds;
    self.checkMarkLayer.path = [self.pathManager pathForCheckMark];
    if ([_animator isEqual:@"BEMAnimationTypeStroke"]) {
        self.checkMarkLayer.strokeColor = self.blue_color.CGColor;
    } else {
        self.checkMarkLayer.strokeColor = [NSColor whiteColor].CGColor;
    }
    self.checkMarkLayer.lineWidth = self.lineWidth;
    self.checkMarkLayer.fillColor = [NSColor clearColor].CGColor;
    self.checkMarkLayer.lineCap = kCALineCapRound;
    self.checkMarkLayer.lineJoin = kCALineJoinRound;
    self.checkMarkLayer.rasterizationScale = 4;
    self.checkMarkLayer.shouldRasterize = YES;
    [self setWantsLayer:YES];
    [self.layer addSublayer:self.checkMarkLayer];
}



@end
