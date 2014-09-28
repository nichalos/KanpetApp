//
//  ViewController.m
//  KanpetApp
//
//  Created by nichalos on 14/9/19.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "KanpetDataSouse.h"
#import "RegexkitLite.h"
#import "SignUpViewController.h"
@interface LoginViewController ()
{
    NSArray *data;
}

@end
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(hideTextField) forControlEvents:UIControlEventTouchUpInside];
    [_background addSubview:control];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _userName)
    {
        [_password becomeFirstResponder];
    }
    else
    {
        [self login:nil];
    }
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    [self moveOffSet:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_userName)
    {
        [self moveOffSet:YES];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (void)hideTextField
{
    
    if ([_userName isFirstResponder]) {
        [_userName resignFirstResponder];
    }
    if ([_password isFirstResponder]) {
        [_password resignFirstResponder];
    }
    [self moveOffSet:NO];
}


-(void)moveOffSet:(BOOL)up
{
    
    const int movementDistance = 140;    //
    const float movementDuration = 0.3f; //
    
    int movement = (up ? -movementDistance : 0);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.bounds, 0, movement);
    
    [UIView commitAnimations];
    
}
-(IBAction)login:(UIButton*)button
{
    [self hideTextField];
    if (![self checkStr:_userName.text]) {
        return;
    }
    if (!_password.text || [_password.text isEqualToString:@""]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"密码不能为空";
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        return;
    }
    __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"登录......";
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES whileExecutingBlock:^{
        data = [[KanpetDataSouse sharedDataSource] loginWithUsername:_userName.text withPassword:_password.text isSignup:NO];
        
    } completionBlock:^{
        if (data) {
            if ([_firstViewController respondsToSelector:@selector(setDataArray:)]) {
                [_firstViewController setDataArray:data];
            }
            [self dismissViewControllerAnimated:YES completion:^{}];
        }else{
            MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:hud];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"账号或密码错误";
            hud.removeFromSuperViewOnHide = YES;
            [hud show:YES];
            [hud hide:YES afterDelay:1];
        }
    }];
    
}
- (BOOL)checkStr:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"账号不能为空";
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        return NO;
    }else if(![str isMatchedByRegex:@"w+([-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*"]){
        return YES;
    }else{
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"账号为邮箱格式";
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        return NO;
    }
    
}

- (void)signUp:(id)sender
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *next = [board instantiateViewControllerWithIdentifier:@"signup"];
    [self.view addSubview:next.view];
}

@end
