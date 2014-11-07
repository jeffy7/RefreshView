//
//  ViewController.m
//  RefreshView
//
//  Created by je_ffy on 14/11/4.
//  Copyright (c) 2014年 je_ffy. All rights reserved.
//

#import "ViewController.h"
#import "FirstView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    FirstView *firstView = [[FirstView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    firstView.VC = self;
    [self.view addSubview:firstView];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
