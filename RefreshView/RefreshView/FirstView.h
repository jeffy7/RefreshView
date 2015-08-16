//
//  FirstView.h
//  RefreshView
//
//  Created by je_ffy on 14/11/6.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "BaseListView.h"
#import "RefreshHeaderView.h"
#import "LoadFooterView.h"
#import "ExecptionView.h"
@class ViewController;
@interface FirstView : BaseListView <UITableViewDataSource,UITableViewDelegate,RefreshHeaderViewDelegate,ExecptionViewDelegate> {
    int _numberOfRow;
    int _currentPage;
    
}
@property (nonatomic, assign)  int numberOfRow;
@property (nonatomic, assign) int currentPage;


@end
