//
//  ViewController.m
//  02.加载Bundle文件
//
//  Created by Rails Chen on 14-9-23.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController


-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    
    [self loadDataFile];
//    [self.webView loadHTMLString:@"<h1>hello<h1/>" baseURL:nil];
//    [self loadFile];
}

#pragma mark - 加载文件
-(void)loadFile
{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"iOS 7 Programming Cookbook.pdf" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    [self.webView loadRequest:request];
    
}


#pragma mark - 以二进制的形式加载文件
-(void)loadDataFile
{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"iOS 7 Programming Cookbook.pdf" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    //服务器响应
    NSURLResponse *response = nil;
    //发送请求给服务器
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    [self.webView loadData:data MIMEType:response.MIMEType textEncodingName:@"UTF8" baseURL:nil];
    
    NSLog(@"%@", response.MIMEType);
    
    
}

-(NSString *)mimeType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //服务器响应
    NSURLResponse *response = nil;
    //发送请求给服务器
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    NSLog(@"%@", response.MIMEType);
    
    return response.MIMEType;
    
}

@end
