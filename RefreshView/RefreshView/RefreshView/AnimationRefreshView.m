//
//  AnimationRefreshView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "AnimationRefreshView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationRefreshView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _startPI = - M_PI_2;
        _endPI = - M_PI_2;
        _maxPI = MAX_PI;
        
        _scrollDValue = SCROLL_D_VALUE;
        _isFullScreen = NO;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)scrollDidScroll:(UIScrollView *)scrollView {
    if (-scrollView.contentOffset.y >= _scrollDValue) {
        float averageValue = MAX_PI_D_VALUE/(-TAR_DRUATION);
        float tarValue = averageValue * (scrollView.contentOffset.y + _scrollDValue);
        
        _endPI = - M_PI_2 - tarValue;
        
        if (_endPI > _maxPI) {
            _endPI = _maxPI;
        }
        [self setNeedsDisplay];
    }
}

- (void)rotateTheCircle {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 1.0;
    self.layer.timeOffset = pausedTime;
    
    CABasicAnimation* rotationAnimation = nil;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)stopTheCircleRote {
    CABasicAnimation *rotationAnimation = (CABasicAnimation *)[self.layer animationForKey:@"rotationAnimation"];
    
    if (rotationAnimation != nil) {
        CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.speed = 0.0;
        self.layer.timeOffset = pausedTime;
    }
}


- (void)clearTheAnimation {
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    
    _endPI = - M_PI_2;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetRGBStrokeColor(context, 48/255.0f, 48/255.0f, 48/255.0f, 1);//改变画笔颜色
    CGContextAddArc(context, REFRESH_CIRCLE_VIEW_RADIUS, REFRESH_CIRCLE_VIEW_RADIUS, REFRESH_CIRCLE_RADIUS, _startPI, _endPI, 0);
    CGContextStrokePath(context);//绘画路径
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    
    if (_isFullScreen == YES) {
        
        _scrollDValue += ((IOS_7_OR_LATER?20.0f:0.0f) + 44.0f);
    }
}


- (void)setContainFilterBar:(BOOL)containFilterBar {
    _containFilterBar = containFilterBar;
    
    if (_containFilterBar == YES) {
        _scrollDValue += ((IOS_7_OR_LATER?20.0f:0.0f) + 64.0f);
    }
}


@end
