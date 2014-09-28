//
//  VedioViewController.h
//  KanpetApp
//
//  Created by nichalos on 14/9/23.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCamera.h"
@interface VedioViewController : UIViewController

@property (nonatomic,strong) UserCamera *userCamera;

- (id)initWithFrame:(CGRect)frame withUserCamera:(UserCamera *)userCamera;
@end
