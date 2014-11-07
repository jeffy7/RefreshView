//
//  LoadFooterView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoadFooterView;

@protocol LoadFooterViewDelegate <NSObject>
@required
- (void)pressedWithNextPageView:(LoadFooterView *)loadView CurrentState:(NextPageViewState)state;

@end

@interface LoadFooterView : UIView {
    NextPageViewState _state;
    
    CGPoint _begainPoint;
    UILabel *_tipLabel;
    UIActivityIndicatorView *_activityView;
    NSArray *_textArray;
    id<LoadFooterViewDelegate> _delegate;
    BOOL _containTabBar;  //是否有tabbar
    BOOL _isTouch;        //用来判断是否点击，即取消点击
}

@property (nonatomic, assign) NextPageViewState state;
@property (nonatomic, assign) CGPoint begainPoint;
@property (nonatomic, retain) UILabel *tipLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) NSArray *textArray;
@property (nonatomic, assign) id <LoadFooterViewDelegate> delegate;
@property (nonatomic, assign) BOOL isTouch;
@property (nonatomic, assign) BOOL containTabBar;


@end
