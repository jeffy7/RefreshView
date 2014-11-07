//
//  BaseListView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "BaseListView.h"

@implementation BaseListView
@synthesize tableView = _tableView;
@synthesize refreshView = _refresfView;
@synthesize exectionView = _exectionView;
@synthesize loadingView = _loadingView;
@synthesize reloading = _reloading;
@synthesize canLoadPic = _canLoadPic;


- (void)dealloc {
    RELEASE_SAFETY(_tableView);
    RELEASE_SAFETY(_refresfView);
    RELEASE_SAFETY(_exectionView);
    RELEASE_SAFETY(_loadingView);
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        _canLoadPic  = YES;
        [self prepareRefreshHeader];
        [self prepareExecptionTipView];
        [self prepareTableViewWithStyle:style];
        [self prepareLoadView];
        [self prepareActivityView];
        
    }
    return self;
}

#pragma mark
#pragma mark - Prepare SubView
- (void)prepareRefreshHeader {
    if (_refresfView == nil) {
        _refresfView = [[RefreshHeaderView alloc] initWithFrame:self.bounds];
        _refresfView.delegate = self;
        _refresfView.isFullScreen = NO;//尝试一下全屏的,意思就是有没有导航栏
        _refresfView.hidden = YES;
    }
    [self addSubview:_refresfView];
}


- (void)prepareExecptionTipView {
    if (_exectionView == nil) {
        _exectionView = [[ExecptionView alloc] initWithFrame:self.bounds];
        _exectionView.delegate = self;
        _exectionView.hidden = YES;
    }
    [self addSubview:_exectionView];
}

- (void)prepareTableViewWithStyle:(UITableViewStyle)style {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
        _tableView.hidden = YES;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor  = [UIColor clearColor];
    }
    [self addSubview:_tableView];
}


- (void)prepareLoadView {
    if (_loadingView ==nil) {
        _loadingView = [[LoadFooterView alloc] init];
        _loadingView.containTabBar = NO;
        _loadingView.delegate = self;
        _loadingView.state = NextPageViewState_Loaded;
        _tableView.tableFooterView = _loadingView;
    }
}


- (void)prepareActivityView {
    if (_activityView == nil) {
        _activityView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = self.center;
        _activityView.hidden = YES;
    }
    [self addSubview:_activityView];
}

#pragma mark
#pragma mark - TableView  Delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark
#pragma mark - Refresh  Delegate
- (void)refreshTableViewHeaderDidTiggerRefresh:(RefreshHeaderView *)refreshView {
    
}

- (BOOL)refreshTablewViewHeadrDataSourceIsLoding:(RefreshHeaderView *)refreshView {
    return _reloading;
}


#pragma mark
#pragma mark - ExecptionView  Delegate
- (void)tipViewTaped:(ExecptionView *)tipView {
    _exectionView.hidden = YES;

}

#pragma mark
#pragma mark - FooterView  Delegate
- (void)pressedWithNextPageView:(LoadFooterView *)loadView CurrentState:(NextPageViewState)state {
    
}
#pragma mark
#pragma mark - ScrollerView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark
#pragma mark - Show and Hidden View  这里以后还要添加加载成功但是没有数据的情况
- (void)hiddenTipView:(ExecptionView *)execptionVuew {
}


- (void)showExecptionTipViewLoadFail {
    _exectionView.hidden = NO;
    _exectionView.delegate = self;
    [self bringSubviewToFront:_exectionView];
    [_exectionView setTipContents:@"加载失败"];
    [_exectionView setTipImage:[UIImage imageNamed:@"SP_al_act_null"]];
}

- (void)hideExecptionTipViewWithNull {
    _exectionView.hidden = YES;
}


- (void)showExecptionTipViewWithNull {
    _exectionView.hidden  = NO;
    _exectionView.delegate = self;
    
    [self bringSubviewToFront:_exectionView];
    [_exectionView setTipContents:@"暂时没有数据"];
    [_exectionView setTipImage:[UIImage imageNamed:@"SP_goods_list_null"]];
    
    
}




- (void)hiddenSubView {
    _tableView.hidden = YES;
    _refresfView.hidden = YES;
    _loadingView.hidden = YES;
    
}


- (void)showSubView {
    _refresfView.hidden = NO;
    _tableView.hidden = NO;
    _loadingView.hidden = NO;
}




- (void)downLoadPic {
    
}


- (void)stopLoadPic {
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
