//
//  RWOAuthViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-3.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWOAuthViewController.h"
#import "RWAccount.h"
#import "RWWeiboTool.h"
#import "RWAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface RWOAuthViewController () <UIWebViewDelegate>

@end

@implementation RWOAuthViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 2.加载授权页面
    NSURL *url = [NSURL URLWithString:IWLoginURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"正在加载"];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求URL的路径
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code在URL中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlstr中包含了code=
    if (range.length) {
        
        // 4.截取code=后面的请求标记（经过用户授权成功的）
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];

        // 5.发送POST请求给新浪，通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
        return NO;
        
    }
    
    return YES;
}


/**
 *  通过code换取一个accessToken
 client_id 	true 	string 	申请应用时分配的AppKey。
 client_secret 	true 	string 	申请应用时分配的AppSecret。
 grant_type 	true 	string 	请求的类型，填写authorization_code
 code 	true 	string 	调用authorize获得的code值。
 redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    
    // 1.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = IWAppKey;
    params[@"client_secret"] = IWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = IWRedirectURI;
    
    // 2.发送请求
    [RWHttpTool postWithURL:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        // 先将字典转为模型
        RWAccount *account = [RWAccount accountWithDict:json];
        
        // 存储模型数据
        [RWAccountTool saveAccount:account];
        
        // 新特性、首页
        [RWWeiboTool chooseRootController];
        
        // 隐藏提醒框
        [MBProgressHUD hideHUD];

    } failure:^(NSError *error) {
        
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}

@end
