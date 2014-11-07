//
//  EcecptionView.m
//  RefreshView
//
//  Created by je_ffy on 14/11/5.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "ExecptionView.h"
#define TIP_IMAGE_FRAME      (CGRectMake(128.0f, 200.0f, 64.0f, 64.0f))
#define TIP_LABEL_FRAME      (CGRectMake(0.0f, 270.0f, 320.0f, 40.0f))

@implementation ExecptionView
@synthesize tipImageView = _tipImageView;
@synthesize tipLabel = _tipLabel;
@synthesize delegate = _delegate;

- (void)dealloc {
    RELEASE_SAFETY(_tipImageView);
    RELEASE_SAFETY(_tipLabel);
    
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareTipImageView];
        [self prepareTipLablel];
    }
    return self;
}


- (void)prepareTipImageView {
    if (_tipImageView == nil) {
        _tipImageView = [[UIImageView alloc] initWithFrame:TIP_IMAGE_FRAME];
        _tipImageView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        _tipImageView.backgroundColor = [UIColor clearColor];
        
    }
    [self addSubview:_tipImageView];
    
}


- (void)prepareTipLablel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:TIP_LABEL_FRAME];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        _tipLabel.backgroundColor = [UIColor clearColor];
    }
    [self addSubview:_tipLabel];
    
}

- (void)setTipContents:(NSString *)content {
    _tipLabel.text = content;
}


- (void)setTipImage:(UIImage *)image {
    _tipImageView.image = image;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if ([_delegate respondsToSelector:@selector(tipViewTaped:)]) {
        [_delegate tipViewTaped:self];
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
