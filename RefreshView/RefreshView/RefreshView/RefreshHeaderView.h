//
//  RefreshHeaderView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationRefreshView.h"

@class RefreshHeaderView;
@protocol RefreshHeaderViewDelegate <NSObject>
@required
- (void)refreshTableViewHeaderDidTiggerRefresh:(RefreshHeaderView *)refreshView;
- (BOOL)refreshTablewViewHeadrDataSourceIsLoding:(RefreshHeaderView *)refreshView;

@end

@interface RefreshHeaderView : UIView {
    PullRefreshState _pullState;
    AnimationRefreshView *_animationRefreshView;
    float _endValue;
    BOOL _isFullScreen;
    BOOL _containFillterBar;
    
    BOOL _isFullScreenWithHeader;
    BOOL _containFillterBarWithHeader;
    id <RefreshHeaderViewDelegate> _delegate;
}
@property (nonatomic, assign) PullRefreshState pullState;
@property (nonatomic, retain) AnimationRefreshView *animationRefreshView;
@property (nonatomic, assign) float endValue;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL containFillterBar;
@property (nonatomic, assign) BOOL isFullScreenWithHeader;
@property (nonatomic, assign) BOOL containFillterBarWithHeader;
@property (nonatomic, assign) id <RefreshHeaderViewDelegate> delegate;

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end
