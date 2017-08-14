//
//  SJViewController.m
//  SJNoticeCycleView
//
//  Created by zhaolong01 on 08/14/2017.
//  Copyright (c) 2017 zhaolong01. All rights reserved.
//

#import "SJViewController.h"
#import <SJNoticeCycleView/SJNoticeCycleView.h>

@interface SJViewController ()

@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *notices = @[
                            @"test1",
                            @"test2",
                            @"test3"
                         ];
    
    SJNoticeCycleView *cycleView = [[SJNoticeCycleView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30) TitleImage:[UIImage imageNamed:@"notice"] NoticeList:notices];
    
    [self.view addSubview:cycleView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
