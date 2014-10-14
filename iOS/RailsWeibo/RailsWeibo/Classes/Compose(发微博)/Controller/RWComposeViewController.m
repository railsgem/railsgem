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
#import "RWComposeToolbar.h"

@interface RWComposeViewController () <UITextViewDelegate, RWComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) RWTextView *textView;
@property (nonatomic, weak) RWComposeToolbar *toolbar;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation RWComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 添加textview
    [self setupTextView];
    
    // 添加toolbar
    [self setupToolbar];
    
    // 添加imageView
    [self setupImageView];
}

/**
 *  添加imageView
 */
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(5, 80, 60, 60);
    [self.textView addSubview:imageView];
    self.imageView = imageView;
}


/**
 *  添加toolbar
 */
-(void)setupToolbar
{
    RWComposeToolbar *toolbar = [[RWComposeToolbar alloc]init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - toolbar的代理方法
- (void)composeToolbar:(RWComposeToolbar *)toolbar didClickedButton:(RWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case RWComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case RWComposeToolbarButtonTypePicture: // 相册
            [self openPhotoLibrary];
            break;
            
        default:
            break;
    }
}

/**
 *  打开相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openPhotoLibrary
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    
    NSLog(@"%@", info);
}


/**
 *  添加textview
 */
-(void)setupTextView
{
    // 1.添加
    RWTextView *textView = [[RWTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 2.监听textview文字改变的通知
    [RWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 3.监听键盘的通知
    [RWNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [RWNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘即将隐藏时候调用
 */
-(void)keyboardWillHide:(NSNotification *)note
{
    // 1.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];

}

/**
 *  键盘即将出现时候调用
 */
-(void)keyboardWillShow:(NSNotification *)note
{
    // 1.取出键盘的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.取出键盘弹出的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
