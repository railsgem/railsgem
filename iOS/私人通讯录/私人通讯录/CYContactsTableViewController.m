//
//  CYContactsTableViewController.m
//  私人通讯录
//
//  Created by Rails Chen on 14-9-16.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "CYContactsTableViewController.h"

@interface CYContactsTableViewController () <UIActionSheetDelegate>
- (IBAction)Logout:(id)sender;

@end

@implementation CYContactsTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/**
 *  注销
 */
- (IBAction)Logout:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


@end
