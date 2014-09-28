//
//  VedioViewController.m
//  KanpetApp
//
//  Created by nichalos on 14/9/23.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "VedioViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CyberPlayerController.h"
#import "KanpetDataSouse.h"
#import "JSONKit.h"
@interface VedioViewController (){
    CyberPlayerController *cbPlayerController;
}

@end

@implementation VedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //请添加您百度开发者中心应用对应的APIKey和SecretKey。
    NSString* msAK=@"I1vGu4VDpOkf28OwAS2BuquU";
    NSString* msSK=@"mXRV0GUQKwKy2BPGUffrQLVeMPrGPGXK";
    
    
    //添加开发者信息
    [[CyberPlayerController class ]setBAEAPIKey:msAK SecretKey:msSK ];
    //当前只支持CyberPlayerController的单实例
    cbPlayerController = [[CyberPlayerController alloc] init];
    //设置视频显示的位置
    [cbPlayerController.view setFrame: CGRectMake(0, (CGRectGetHeight(self.view.frame)-200)/2, 320, 200)];
    //将视频显示view添加到当前view中
    [self.view addSubview:cbPlayerController.view];
    [self startPlayback];
    //注册监听，当播放器完成视频的初始化后会发送CyberPlayerLoadDidPreparedNotification通知，
    //此时naturalSize/videoHeight/videoWidth/duration等属性有效。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onpreparedListener:)
                                                 name: CyberPlayerLoadDidPreparedNotification
                                               object:nil];
    UITapGestureRecognizer *tap3Gesture = nil;
    tap3Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickListener:)];//touch action
    tap3Gesture.numberOfTapsRequired = 1;
    tap3Gesture.cancelsTouchesInView = NO;
    tap3Gesture.delaysTouchesEnded = NO;
    [cbPlayerController.view addGestureRecognizer:tap3Gesture];
    [super viewDidLoad];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [cbPlayerController stop];
    [super viewWillDisappear:animated];
}
- (void)startPlayback{
    
    __block NSURL *url;
    __block typeof(self) selfs = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSString *urlStr = [[KanpetDataSouse sharedDataSource] getVedioUrlWithShardID:_shareID withUK:_uk];
        url = [NSURL URLWithString:urlStr];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (url) {
                switch (cbPlayerController.playbackState) {
                    case CBPMoviePlaybackStateStopped:
                    case CBPMoviePlaybackStateInterrupted:
                        [cbPlayerController setContentURL:url];
                        //初始化完成后直接播放视频，不需要调用play方法
                        cbPlayerController.shouldAutoplay = YES;
                        //初始化视频文件
                        [cbPlayerController prepareToPlay];
                        break;
                    case CBPMoviePlaybackStatePlaying:
                        //如果当前正在播放视频时，暂停播放。
                        [cbPlayerController pause];
                        break;
                    case CBPMoviePlaybackStatePaused:
                        //如果当前播放视频已经暂停，重新开始播放。
                        [cbPlayerController start];
                        break;
                    default:
                        break;
                }
            }else{
                UILabel *errorLable = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMinY(cbPlayerController.view.frame)-30, CGRectGetWidth(cbPlayerController.view.frame)-40, 30)];
                errorLable.text = urlStr;
                errorLable.textAlignment = NSTextAlignmentLeft;
                [selfs.view addSubview:errorLable];
            }
        });
    });

}
- (void) onpreparedListener: (NSNotification*)aNotification
{
    NSLog(@"%@",aNotification.object);
}
- (void)onClickListener:(NSNotification*)aNotification
{
//    CGRect aFrame = [[UIScreen mainScreen] applicationFrame];
//    aFrame = CGRectMake(0.0f, 0.0f, aFrame.size.width, aFrame.size.height);
//    
////    cbPlayerController.controlStyle = MPMovieControlStyleDefault;
//    cbPlayerController.view.frame = aFrame;
//    cbPlayerController.view.center = CGPointMake(aFrame.size.width/2, aFrame.size.height/2);
//    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
//    [cbPlayerController.view setTransform:transform];
//    [[[[UIApplication sharedApplication] delegate] window] addSubview:cbPlayerController.view];
//    cbPlayerController.scalingMode = CBPMovieScalingModeFill;
}
//- (void)stopPlayback{
//    //停止视频播放
//    [cbPlayerController stop];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
