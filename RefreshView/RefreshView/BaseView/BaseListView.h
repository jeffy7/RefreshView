//
//  BaseListView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeaderView.h"
#import "LoadFooterView.h"
#import "ExecptionView.h"

@interface BaseListView : UIView <UITableViewDelegate, UITableViewDataSource,RefreshHeaderViewDelegate,ExecptionViewDelegate,LoadFooterViewDelegate> {

    UITableView *_tableView;
    BOOL _reloading;
    RefreshHeaderView *_refresfView;
    LoadFooterView *_loadingView;
    ExecptionView *_exectionView;
    NextPageViewState _nextPageState;
    BOOL _canLoadPic;
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) BOOL reloading;
@property (nonatomic, retain) RefreshHeaderView *refreshView;
@property (nonatomic, retain) LoadFooterView *loadingView;
@property (nonatomic, retain) ExecptionView *exectionView;
@property (nonatomic, assign) NextPageViewState nextPageState;
@property (nonatomic, assign) BOOL canLoadPic;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)hiddenSubView;
- (void)showSubView;

- (void)hiddenTipView:(ExecptionView *)execptionVuew;
- (void)showExecptionTipViewLoadFail;
- (void)hideExecptionTipViewWithNull;
- (void)showExecptionTipViewWithNull;


- (void)downLoadPic;
- (void)stopLoadPic;


@end
