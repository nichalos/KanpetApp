//
//  SettingViewController.m
//  KanpetApp
//
//  Created by Junfeng Bai on 14/9/26.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "SettingViewController.h"
//#import "SettingTableViewCell.h"
@interface SettingViewController ()
{
    NSArray *dataArray;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *name = [NSString stringWithFormat:@"账号：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"USER_NAME"]];
     dataArray = [NSArray arrayWithObjects:name,@"检测版本更新",@"关于", nil];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}



- (IBAction)logout:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_INFO"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_NAME"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"USER_PASSWORD"];
    [self.navigationController popViewControllerAnimated:YES];
    if ([_firstViewController respondsToSelector:@selector(backSuperViewContriller)]) {
        [_firstViewController backSuperViewContriller];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
