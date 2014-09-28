//
//  HomeViewController.m
//  KanpetApp
//
//  Created by nichalos on 14/9/20.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "HomeViewController.h"
#import "VedioViewController.h"
#import "KanpetDataSouse.h"
#import "HomeTableViewCell.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD.h"
#import "UserCamera.h"
#import "SettingViewController.h"
#import "MJRefresh.h"
@interface HomeViewController ()
{
    NSArray *dataArray;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:228/255.0 green:229/255.0 blue:233/255.0 alpha:1];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_PASSWORD"];
    if (!userName || !password) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }else{
        [self setupRefresh];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];

    [self.tableView headerBeginRefreshing];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"哥正在帮你刷新中,不客气";
}

- (void)headerRereshing
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_PASSWORD"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dataArray = [[KanpetDataSouse sharedDataSource] loginWithUsername:userName withPassword:password isSignup:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dataArray) {
                if (dataArray.count != 0) {
                    [_noDataView removeFromSuperview];
                    [self.tableView reloadData];
                    [self.tableView headerEndRefreshing];
                }
            }else{
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:hud];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"登陆过期，请重新登录";
                hud.removeFromSuperViewOnHide = YES;
                [hud show:YES];
                [hud hide:YES afterDelay:1];
                [self performSegueWithIdentifier:@"login" sender:self];
            }
        });
    });
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
   
    cell.name.text = [NSString stringWithFormat:@"name%d",indexPath.row];
    cell.VedioImage.image = [UIImage imageNamed:@"cry"];
    __block typeof(cell) cells = cell;
    __block NSString *url;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UserCamera *item = [dataArray objectAtIndex:indexPath.row];
        url = [[KanpetDataSouse sharedDataSource] getImageUrlWithShardID:item.shareID withUK:item.uk];
        dispatch_async(dispatch_get_main_queue(), ^{
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager downloadImageWithURL:[NSURL URLWithString:url]
                                  options:0
                                 progress:^(NSInteger receivedSize, NSInteger expectedSize){}
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished,NSURL *imageURL )
             {
                 [cells.myIndicator stopAnimating];
                 if (image)
                 {
                     // do something with image
                     cells.VedioImage.image = image;
                 }else{
                     cells.backGround.image = [UIImage imageNamed:@"cry"];
                 }
             }];
        });
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArray.count<=indexPath.row) {
        return;
    }
    VedioViewController *vedioVC = [[VedioViewController alloc] init];
    vedioVC.view.frame = self.view.frame;
    vedioVC.userCamera = [dataArray objectAtIndex:indexPath.row];
    vedioVC.shareID = [dataArray[indexPath.row] shareID];
    vedioVC.uk = [dataArray[indexPath.row] uk];
    [self.navigationController pushViewController:vedioVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
}

- (void)setDataArray:(NSArray *)data
{
    dataArray = data;
    [self setupRefresh];
}

- (IBAction)showSettingView:(id)sender
{
    
    [self performSegueWithIdentifier:@"setting" sender:self];
}

- (void)backSuperViewContriller
{
    [self performSegueWithIdentifier:@"login" sender:self];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* view = segue.destinationViewController;  
    if ([view respondsToSelector:@selector(setFirstViewController:)]) {
        [view setValue:self forKey:@"firstViewController"];
    }
}


@end
