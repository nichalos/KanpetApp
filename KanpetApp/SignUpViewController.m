//
//  SignUpViewController.m
//  KanpetApp
//
//  Created by nichalos on 14/9/23.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "SignUpViewController.h"
#import "MBProgressHUD.h"
#import "KanpetDataSouse.h"
#import "RegexkitLite.h"
@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    [control addTarget:self action:@selector(hideTextField) forControlEvents:UIControlEventTouchUpInside];
    [_bacView addSubview:control];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackHome
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _userName)
    {
        [_password becomeFirstResponder];
        
    }else if(textField == _password){
        [_checkPassword becomeFirstResponder];
    }
    else
    {
        [self signUp:nil];
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
    if ([_checkPassword isFirstResponder]) {
        [_checkPassword resignFirstResponder];
    }
    [self moveOffSet:NO];
}


-(void)moveOffSet:(BOOL)up
{
    
    const int movementDistance = 50;    //
    const float movementDuration = 0.3f; //
    
    int movement = (up ? -movementDistance : 0);
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.bounds, 0, movement);
    
    [UIView commitAnimations];
    
}
-(IBAction)signUp:(UIButton*)button
{
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
    if((_checkPassword.text && [_checkPassword.text isEqualToString:_password.text]))
    {
        
        __block MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"注册......";
        hud.removeFromSuperViewOnHide = YES;
        [hud showAnimated:YES whileExecutingBlock:^{
            BOOL isLoginSuccess = [[KanpetDataSouse sharedDataSource] signWithUsername:_userName.text withPassword:_password.text isSignup:YES];
            if (isLoginSuccess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self goBackHome];
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                    [self.view addSubview:hud];
                    hud.mode = MBProgressHUDModeText;
                    hud.labelText = @"注册失败";
                    hud.removeFromSuperViewOnHide = YES;
                    [hud show:YES];
                    [hud hide:YES afterDelay:1];
                    _userName.text = @"";
                    _password.text = @"";
                    _checkPassword.text = @"";
                });
            }
        }];
    }else{
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"两次输入的密码不一样";
        hud.removeFromSuperViewOnHide = YES;
        [hud show:YES];
        [hud hide:YES afterDelay:1];
    }
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
