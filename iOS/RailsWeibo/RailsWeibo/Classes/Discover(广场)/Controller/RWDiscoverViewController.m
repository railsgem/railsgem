//
//  RWDiscoverViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-25.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
// 广场（发现 ）

#import "RWDiscoverViewController.h"
#import "RWSearchBar.h"

@interface RWDiscoverViewController ()

@end

@implementation RWDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RWSearchBar *searchBar = [[RWSearchBar alloc] init];
    
    // 尺寸
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    
    // 设置中间的标题内容
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


@end
