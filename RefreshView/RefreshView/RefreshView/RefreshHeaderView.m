//
//  RefreshHeaderView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "RefreshHeaderView.h"

@implementation RefreshHeaderView
@synthesize pullState = _pullState;
@synthesize animationRefreshView = _animationRefreshView;
@synthesize endValue = _endValue;
@synthesize isFullScreen = _isFullScreen;
@synthesize containFillterBar = _containFillterBar;
@synthesize isFullScreenWithHeader = _isFullScreenWithHeader;
@synthesize containFillterBarWithHeader = _containFillterBarWithHeader;


- (void)dealloc {
    RELEASE_SAFETY(_animationRefreshView);
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        _endValue = END_DRUATION;
        _isFullScreen = NO;
        _isFullScreenWithHeader = NO;
        
        [self setPullState:PullRefreshState_Normal];
        
        [self prepareAnimationRefreshView];
    }
    return self;
}

- (void)prepareAnimationRefreshView {
    if (_animationRefreshView == nil) {
        _animationRefreshView = [[AnimationRefreshView alloc] initWithFrame:REFRESH_CIRCLE_VIEW_FRAME];
    }
    [self addSubview:_animationRefreshView];
    
}


- (void)setPullState:(PullRefreshState)pullState {
    _pullState = pullState;
}


#pragma mark
#pragma mark - ScrollerView  Methods
- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pullState == PullRefreshState_Loading) {
        CGFloat offset = MAX(scrollView.contentOffset.y *-1, 0);
        offset = MIN(offset, -(_endValue +5.0f));
        
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    }else if (scrollView.isDragging) {
        if (_pullState == PullRefreshState_Normal) {
            [_animationRefreshView scrollDidScroll:scrollView];
        }
        BOOL _loding = NO;
        if ([_delegate respondsToSelector:@selector(refreshScrollViewDataSourceDidFinishedLoading:)]) {
            _loding = [_delegate refreshTablewViewHeadrDataSourceIsLoding:self];
        }
        
        if (_pullState == PullRefreshState_Pulling && scrollView.contentOffset.y > _endValue && scrollView.contentOffset.y < 0.0f && !_loding) {
            //正常状态
            [self setPullState:PullRefreshState_Normal];
            NSLog(@" normal....  ");
            
        }else if (_pullState == PullRefreshState_Normal && scrollView.contentOffset.y < _endValue && !_loding) {
            [self setPullState:PullRefreshState_Pulling];
            
            NSLog(@" reloading....  ");
        }
        
        
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
}
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    
    BOOL _loding = NO;
    if ([_delegate respondsToSelector:@selector(refreshTablewViewHeadrDataSourceIsLoding:)]) {
        _loding  = [_delegate refreshTablewViewHeadrDataSourceIsLoding:self];
    }
    if (scrollView.contentOffset.y <= _endValue && ! _loding) {
        if ([_delegate respondsToSelector:@selector(refreshTablewViewHeadrDataSourceIsLoding:)]) {
            [_delegate refreshTableViewHeaderDidTiggerRefresh:self];
            [_animationRefreshView rotateTheCircle];
        }
        [self setPullState:PullRefreshState_Loading];
        
        [UIView animateWithDuration:0.2f animations:^{
            //用时0.2秒  将其固定在60的位置
            scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        } completion:^(BOOL finished) {
            
        }];
        
    }
}
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [_animationRefreshView stopTheCircleRote];
    
    [UIView animateWithDuration:0.3f animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [_animationRefreshView clearTheAnimation];
    }];
    
    [self setPullState:PullRefreshState_Normal];
    
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    
    if (_isFullScreen == YES) {
        _endValue -= ((IOS_7_OR_LATER?20.0f:0.0f) + 44.0f);
        
        CGRect refreshCircleFrame = _animationRefreshView.frame;
        refreshCircleFrame.origin.y += ((IOS_7_OR_LATER?20.0f:0.0f) + 44.0f);
        _animationRefreshView.frame = refreshCircleFrame;
        
        _animationRefreshView.isFullScreen = _isFullScreen;
    }
}


- (void)setContainFillterBar:(BOOL)containFillterBar {
    _containFillterBar = containFillterBar;
    
    if (_containFillterBar == YES) {
        _endValue -= ((IOS_7_OR_LATER?20.0f:0.0f) + 64.0f);
        
        CGRect refreshCircleFrame = _animationRefreshView.frame;
        refreshCircleFrame.origin.y += ((IOS_7_OR_LATER?20.0f:0.0f) + 74.0f);
        _animationRefreshView.frame = refreshCircleFrame;
        
        _animationRefreshView.isFullScreen = _containFillterBar;
    }
}


- (void)setIsFullScreenWithHeader:(BOOL)isFullScreenWithHeader {
    _isFullScreenWithHeader = isFullScreenWithHeader;
    
    if (_isFullScreenWithHeader == YES) {
        CGRect refreshCircleFrame = _animationRefreshView.frame;
        refreshCircleFrame.origin.y += ((IOS_7_OR_LATER?20.0f:0.0f) + 44.0f);
        _animationRefreshView.frame = refreshCircleFrame;
    }
}


- (void)setContainFillterBarWithHeader:(BOOL)containFillterBarWithHeader {
    _containFillterBarWithHeader = containFillterBarWithHeader;
    
    if (_containFillterBarWithHeader == YES) {
        CGRect refreshCircleFrame = _animationRefreshView.frame;
        refreshCircleFrame.origin.y += ((IOS_7_OR_LATER?20.0f:0.0f) + 74.0f);
        _animationRefreshView.frame = refreshCircleFrame;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
