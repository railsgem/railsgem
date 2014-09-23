//
//  ViewController.m
//  01.UIWebView
//
//  Created by Rails Chen on 14-9-23.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1.定义URL
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
}

//让浏览器加载指定的字符串
-(void)loadString:(NSString *)str
{
    NSString *urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
    
    //1.定义URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
}

#pragma mark -搜索栏代理方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked - %@", searchBar.text);
    [self loadString:searchBar.text];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText - %@", searchText);
}

@end
