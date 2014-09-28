//
//  ViewController.h
//  KanpetApp
//
//  Created by nichalos on 14/9/19.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate
-(void)setDataArray:(NSArray *)data;
@end

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
}

@property (strong,nonatomic) id firstViewController;
@property (nonatomic,strong) IBOutlet UIButton *login;
@property (nonatomic,strong) IBOutlet UITextField *userName;
@property (nonatomic,strong) IBOutlet UITextField *password;
@property (nonatomic,strong) IBOutlet UIImageView *background;
-(IBAction)login:(UIButton*)button;
-(IBAction)signUp:(id)sender;
@end

