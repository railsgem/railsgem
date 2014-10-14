//
//  RWComposeViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-13.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWComposeViewController.h"
#import "AFNetworking.h"
#import "RWTextView.h"
#import "RWAccount.h"
#import "RWAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface RWComposeViewController ()
@property (nonatomic,weak) RWTextView *textView;

@end

@implementation RWComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textview
    [self setupTextView];
   
}

/**
 *  添加textview
 */
-(void)setupTextView
{
    // 1.添加
    RWTextView *textView = [[RWTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听
    [RWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

/**
 *  监听文字改变
 */
-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
}

-(void) dealloc
{
    [RWNotificationCenter removeObserver:self];
}

/**
 *  设置导航栏属性
 */
-(void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.title = @"发微博";
}

/**
 *  取消
 */
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送微博
 */
-(void)send
{
    
    // 创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [RWAccountTool account].access_token;
    
    // 发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];

        
    }];

    // 4.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
