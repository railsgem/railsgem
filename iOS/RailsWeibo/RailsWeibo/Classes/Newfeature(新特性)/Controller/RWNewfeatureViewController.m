//
//  RWNewfeatureViewController.m
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-3.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "RWNewfeatureViewController.h"
#define RWNewfeatureImageCount 3

@interface RWNewfeatureViewController ()

@end

@implementation RWNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0 ; index < RWNewfeatureImageCount; index ++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        CGFloat imageX = imageW * index;
        
        // 设置frame
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        imageView.image = [UIImage imageWithName:name];
        
        [scrollView addSubview:imageView];
    }
    
    // 设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * RWNewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
//    scrollView.backgroundColor = RWColor(246, 246, 246);
    scrollView.bounces = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
