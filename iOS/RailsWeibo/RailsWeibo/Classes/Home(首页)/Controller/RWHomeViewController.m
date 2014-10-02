//
//  RWHomeViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-9-25.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWHomeViewController.h"
#import "RWBadgeButton.h"
#import "UIBarButtonItem+CY.h"

@interface RWHomeViewController ()

@end

@implementation RWHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    // 左边按钮
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
//    // 右边按钮
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
//    
    
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
}

- (void)findFriend
{
    RWLog(@"findFriend");
}

- (void)pop
{
    RWLog(@"pop");
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //设置cell的数据
    cell.textLabel.text = @"aaaa";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
