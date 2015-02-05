//
//  TGMainController.m
//  单身狗
//
//  Created by Rails Chen on 15/1/20.
//  Copyright (c) 2015年 Railsgem. All rights reserved.
//

#import "TGMainController.h"
#import "TGDock.h"

@interface TGMainController ()

@end

@implementation TGMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    TGDock *dock = [[TGDock alloc] init];
    [self.view addSubview:dock];
    
    
}


@end
