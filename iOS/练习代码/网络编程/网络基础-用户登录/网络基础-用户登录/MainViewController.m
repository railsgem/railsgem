//
//  MainViewController.m
//  网络基础-用户登录
//
//  Created by Rails Chen on 15/1/18.
//  Copyright (c) 2015年 Railsgem. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) UITextField *nameTextField;
@property (weak, nonatomic) UITextField *passwordTextField;

@end

@implementation MainViewController

#pragma mark 设置界面
- (void)setupUI
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
    
    for (NSInteger i = 0; i < 2; i++) {
        //1.两个label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20 + i * 40, 80, 40)];
        [self.view addSubview:label];
        [arrayM addObject:label];
    }
    for (NSInteger i = 0; i < 2; i++) {
        //2.两个textfield
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 20 + i * 40, 200, 32)];
        
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        [self.view addSubview:textField];
        [arrayM addObject:textField];
    }
    // 3. 设置label
    [(UILabel *)arrayM[0]setText:@"用户名："];
    [(UILabel *)arrayM[1]setText:@"密码："];
    
    self.nameTextField = arrayM[2];
    self.passwordTextField = arrayM[3];
    
    // 设置密码输入
    [self.passwordTextField setSecureTextEntry:YES];
    
    // 4. 1个UIButton
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(100, 106, 200, 40)];
    
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮监听方法
- (void)login
{
   
    
    NSLog(@"come here");
    
}


@end
