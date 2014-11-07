//
//  EcecptionView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/5.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExecptionView;
@protocol ExecptionViewDelegate <NSObject>
@required
- (void)tipViewTaped:(ExecptionView *)tipView;

@end

@interface ExecptionView : UIView {
    id <ExecptionViewDelegate> _delegate;
    UIImageView *_tipImageView;
    UILabel *_tipLabel;
}

@property (nonatomic, assign) id <ExecptionViewDelegate> delegate;
@property (nonatomic, retain) UIImageView *tipImageView;
@property (nonatomic, retain) UILabel *tipLabel;

- (void)setTipImage:(UIImage *)image;
- (void)setTipContents:(NSString *)content;


@end
