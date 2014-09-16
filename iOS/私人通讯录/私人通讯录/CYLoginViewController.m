//
//  CYLoginViewController.m
//  私人通讯录
//
//  Created by Rails Chen on 14-9-16.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//

#import "CYLoginViewController.h"

@interface CYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
- (IBAction)rmbPwdChange;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
- (IBAction)autoLoginChange;

@end

@implementation CYLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    

}
/**
 * 移除监听
 */
-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  文本框的文字发生改变的时候调用到
 */

-(void)textChange
{
    self.loginBtn.enabled = (self.accountField.text.length && self.pwdField.text.length );
}

/**
 *  记住密码 的开关的状态改变时调用
 */
- (IBAction)rmbPwdChange{
    //取消记住密码
    if (self.rmbPwdSwitch.isOn == NO) {
        self.autoLoginSwitch.on = NO;
    }
}

/**
 *  自动登录的开关状态改变就会自动调用
 */
- (IBAction)autoLoginChange {
    //打开自动登录
    if (self.autoLoginSwitch.isOn) {
        self.rmbPwdSwitch.on = YES;
    }
}
@end
