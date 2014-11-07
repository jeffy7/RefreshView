//
//  AnimationRefreshView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
//这个可定制  可自己重绘刷新时的图案，也可做动画组
@interface AnimationRefreshView : UIView {
@private
    float _startPI;
    float _endPI;
    float _maxPI;
    
    float _angle;
    
    float _scrollDValue;
    
    BOOL _isFullScreen;
    BOOL _containFilterBar;
}
@property (nonatomic, assign) float startPI;
@property (nonatomic, assign) float endPI;
@property (nonatomic, assign) float maxPI;

@property (nonatomic, assign) float angle;
@property (nonatomic, assign) float scrollDValue;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL containFilterBar;

- (void)scrollDidScroll:(UIScrollView *)scrollView;
- (void)rotateTheCircle;
- (void)stopTheCircleRote;
- (void)clearTheAnimation;

@end
