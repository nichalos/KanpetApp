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
@property (nonatomic,strong) NSString *shareID;
@property (nonatomic,strong) NSString *uk;
@end
