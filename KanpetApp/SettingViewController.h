//
//  SettingViewController.h
//  KanpetApp
//
//  Created by Junfeng Bai on 14/9/26.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SettingViewControllerDelegate
-(void)backSuperViewContriller;
@end

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) id firstViewController;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) IBOutlet UIButton *logOut;
-(IBAction)logout:(id)sender;
@end
