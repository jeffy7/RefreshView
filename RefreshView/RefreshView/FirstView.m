//
//  FirstView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/6.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "FirstView.h"
@implementation FirstView

- (void)dealloc {
    
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        _currentPage = 1;
        _tableView.backgroundView = nil;
        _tableView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        _activityView.hidden = NO;
        [_activityView startAnimating];
        [self resquestData];

    }
    return self;
}

#pragma mark
#pragma mark - resquestData
- (void)resquestData {
    
#if 1
    //模拟数据成功
    [self performSelector:@selector(succeed) withObject:nil afterDelay:3.0f];
#else
    [self performSelector:@selector(Failed) withObject:nil afterDelay:3.0f];
    
#endif
}

- (void)succeed {

    if (_currentPage == 1) {
        _numberOfRow = 20;
    }else {
        _numberOfRow += 5;
    }
    
    _reloading = NO;
    [_activityView stopAnimating];
    _activityView.hidden = YES;
    
    [self showSubView];
    [_refresfView refreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];


    _loadingView.state = NextPageViewState_Loaded;//看返回的数据判断  再决定是什么情况
    _tableView.tableFooterView = _loadingView;
    _tableView.tableFooterView.userInteractionEnabled = YES;
    _tableView.tableFooterView.hidden = NO;
    
}


- (void)Failed {
    _reloading = NO;
    [_activityView stopAnimating];
    [self hiddenSubView];
    _loadingView.state = NextPageViewState_Faild;
    _tableView.tableFooterView.userInteractionEnabled = YES;
    _tableView.tableFooterView.hidden = NO;
    
    [self showExecptionTipViewLoadFail];
    [_refresfView refreshScrollViewDataSourceDidFinishedLoading:_tableView];
    
}

#pragma mark
#pragma mark - ExecptionView Delegate
- (void)tipViewTaped:(ExecptionView *)tipView {
    _exectionView.hidden = YES;
    _activityView.hidden = NO;
    [_activityView startAnimating];
    _currentPage = 1;
    [self resquestData];
}

#pragma mark
#pragma mark - some delegate
- (void)refreshTableViewHeaderDidTiggerRefresh:(RefreshHeaderView *)refreshView {
    [self stopLoadPic];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayRef) object:nil];
    [self performSelector:@selector(delayRef) withObject:nil afterDelay:0.5f];
    _reloading = YES;
    
    //隐藏加载视图
    _tableView.tableFooterView.userInteractionEnabled = NO;
    _tableView.tableFooterView.hidden = YES;
}

- (BOOL)refreshTablewViewHeadrDataSourceIsLoding:(RefreshHeaderView *)refreshView {
    return _reloading;
}

- (void)delayRef {
    //处理下拉刷新
    _currentPage ++;
    [self resquestData];
}


#pragma mark
#pragma mark - ScrollerView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_refresfView refreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_refresfView refreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //这个逻辑可要可不要  仿网易滑动到最低端自动加载下一页
    CGSize scrollerSize = scrollView.contentSize;
    CGPoint offSide = scrollView.contentOffset;
    float tableFooterOffset = offSide.y + scrollView.frame.size.height;
    if (tableFooterOffset == scrollerSize.height) {
        if (_reloading == NO) {
            //在没有网络请求的情况下 开始加载下一页
            [self pressedWithNextPageView:_loadingView CurrentState:_nextPageState];
        }
    }
}

- (void)pressedWithNextPageView:(LoadFooterView *)loadView CurrentState:(NextPageViewState)state {
    [super pressedWithNextPageView:loadView CurrentState:state];
    _nextPageState = state;
    if (state == NextPageViewState_Loaded || state == NextPageViewState_Faild) {
        _loadingView.state = NextPageViewState_Loading;
        _refresfView.hidden = YES;
        _tableView.tableFooterView = _loadingView;
        [self stopLoadPic];
        [self performSelector:@selector(nextPageDelayToLoad) withObject:nil afterDelay:0.5f];
    }
}

- (void)nextPageDelayToLoad {
    //加载下一页
    
    _currentPage ++;
    [self resquestData];
}
#pragma mark
#pragma mark - NextPage


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numberOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text = @"Test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
