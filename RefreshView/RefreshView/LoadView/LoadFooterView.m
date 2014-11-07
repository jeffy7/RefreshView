//
//  LoadFooterView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "LoadFooterView.h"

@implementation LoadFooterView
@synthesize state = _state;
@synthesize begainPoint = _begainPoint;
@synthesize tipLabel = _tipLabel;
@synthesize activityView = _activityView;
@synthesize textArray = _textArray;
@synthesize delegate = _delegate;
@synthesize containTabBar = _containTabBar;
@synthesize isTouch = _isTouch;

- (void)dealloc {
    RELEASE_SAFETY(_tipLabel);
    RELEASE_SAFETY(_activityView);
    RELEASE_SAFETY(_textArray);
    [super dealloc];
}


- (id)init {
    self = [super init];
    if (self) {
        _isTouch = NO;
        _containTabBar = NO;
        [self prepareLabel];
        
        [self prepareActivityView];
        
        _textArray = [[NSArray alloc] initWithObjects:@"点击加载更多",@"正在加载...",@"加载失败，点击重试",@"已经是最后一页了",@"", nil];
    }
    return self;
}


- (void)prepareLabel {
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 220, 60)];
    _tipLabel.textColor = [UIColor grayColor];
    _tipLabel.backgroundColor = [UIColor clearColor];
    _tipLabel.font = [UIFont systemFontOfSize:14];
    _tipLabel.textAlignment = NSTextAlignmentLeft;
    _tipLabel.numberOfLines = 10;
    [self addSubview:_tipLabel];
}


- (void)prepareActivityView {
    _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(80, 20, 20, 20)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [_activityView stopAnimating];
    [self addSubview:_activityView];
    
}

- (void)setState:(NextPageViewState)state {
    [self catchTheFrameWithSubViewWithState:state];

    if (state == NextPageViewState_Loaded) {
        self.userInteractionEnabled = YES;
        _tipLabel.text = [_textArray objectAtIndex:0];
        _activityView.hidden = YES;
        [_activityView stopAnimating];
        
    }else if(state == NextPageViewState_Loading) {
        self.userInteractionEnabled = NO;
        _tipLabel.text = [_textArray objectAtIndex:1];
        _activityView.hidden = NO;
        [_activityView startAnimating];
        
    }else if(state == NextPageViewState_Faild) {
        self.userInteractionEnabled = YES;
        _tipLabel.text = [_textArray objectAtIndex:2];
        _activityView.hidden = YES;
        [_activityView stopAnimating];
        
    }else if(state == NextPageViewState_NoMore) {
        self.userInteractionEnabled = YES;
        _tipLabel.text = [_textArray objectAtIndex:3];
        _activityView.hidden = YES;
        [_activityView stopAnimating];
    }else if(state == NextPageViewState_Hidden) {
        self.userInteractionEnabled = YES;
        _tipLabel.text = [_textArray objectAtIndex:4];
        _activityView.hidden = YES;
        [_activityView stopAnimating];
    }
    _state = state;
    
}

- (void)catchTheFrameWithSubViewWithState:(NextPageViewState)state {
    if (state == NextPageViewState_Loaded || state == NextPageViewState_Loading || state == NextPageViewState_Faild || state == NextPageViewState_NoMore||state == NextPageViewState_Hidden) {
        if (_containTabBar == YES) {
            self.frame = CGRectMake(0, 0, 320, 60.0f + 49.0f);
            _tipLabel.frame = CGRectMake(110, 0, 220, 60.0f);
        }
        else {
            self.frame = CGRectMake(0, 0, 320, 60.0f);
            _tipLabel.frame = CGRectMake(110, 0, 220, 60.0f);
        }
    }
    if (state == NextPageViewState_Hidden) {
        if (_containTabBar == YES) {
            self.frame = CGRectMake(0, 0, 320, 0 + 49.0f);
            _tipLabel.frame = CGRectMake(0, 0, 220, 0);
        }
        else {
            self.frame = CGRectMake(0, 0, 320, 0);
            _tipLabel.frame = CGRectMake(0, 0, 220, 0);
        }
    }
}

#pragma mark
#pragma mark - Touch Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _begainPoint = [touch locationInView:self];
    _isTouch = YES;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    float _y = _begainPoint.y - point.y;
    if (_y >100 ||_y < -100) {
        //表示取消点击事件
        _isTouch = NO;
        [_tipLabel setBackgroundColor:[UIColor clearColor]];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_isTouch) {
        if ([_delegate respondsToSelector:@selector(pressedWithNextPageView:CurrentState:)]) {
            [_delegate pressedWithNextPageView:self CurrentState:_state];
        }
    }
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    _isTouch = NO;
    [_tipLabel setBackgroundColor:[UIColor clearColor]];
}


- (void)setContainTabBar:(BOOL)containTabBar {
    _containTabBar = containTabBar;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
