//
//  HomeViewController.h
//  KanpetApp
//
//  Created by nichalos on 14/9/20.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "SettingViewController.h"
@interface HomeViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,ViewControllerDelegate,SettingViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *noDataView;

@end
