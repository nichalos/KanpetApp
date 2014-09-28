//
//  SignUpViewController.h
//  KanpetApp
//
//  Created by nichalos on 14/9/23.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,strong) IBOutlet UITextField *userName;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UITextField *checkPassword;
@property (nonatomic,strong) IBOutlet UIView *bacView;
-(IBAction)signUp:(UIButton*)button;
@end
