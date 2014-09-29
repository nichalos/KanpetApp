//
//  KanpetDataSouse.m
//  KanpetApp
//
//  Created by nichalos on 14/9/20.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import "KanpetDataSouse.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "UserCamera.h"
#define SHAREID @"4eb224c1e7168099d2d1afddbcf01ebf"
#define UK @"184904776"
static KanpetDataSouse *dataSource = nil;
@implementation KanpetDataSouse
- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}


+ (KanpetDataSouse *)sharedDataSource{
    if (!dataSource) {
        dataSource = [[KanpetDataSouse alloc] init];
    }
    
    return dataSource;
}
-(NSDictionary *)getJsonWithUrl:(NSString *)url
{
    NSURL *httpUrl =[NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:httpUrl];
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    request.timeOutSeconds = 600;
    [request startSynchronous];
    NSError *error = [request error];
    if (!error)
    {
        NSString *dic = [request responseString];
       __autoreleasing NSDictionary *nstr = [dic objectFromJSONString];
        return nstr;
    }
    return nil;
}
-(NSArray *)loginWithUsername:(NSString *)username withPassword:(NSString *)password isSignup:(BOOL)isSignUp;
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *baseUrl = @"Admin/Login/apiLogin";
    NSString *url = [NSString stringWithFormat:@"http://www.kanpet.cn/%@?username=%@&password=%@",baseUrl,username,password];
    NSDictionary *nstr = [self getJsonWithUrl:url];
    if (nstr) {
        NSInteger flog = [[nstr objectForKey:@"status"] integerValue];
        if (flog) {
            NSArray *dataArray = [nstr valueForKey:@"cameraParam"];
            for (int i = 0; i<dataArray.count; i++) {
                NSString *shardID = [dataArray[i] valueForKey:@"shareid"];
                NSString *uk = [dataArray[i] valueForKey:@"uk"];
                if (!(uk && [uk isKindOfClass:[NSNull class]]) && !(shardID && [shardID isKindOfClass:[NSNull class]])) {
                    UserCamera *userCamera = [[UserCamera alloc] init];
                    userCamera.shareID = shardID;
                    userCamera.uk = uk;
                    [data addObject:userCamera];
                }
            }
            [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"USER_NAME"];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"USER_PASSWORD"];
        }
        return data;
    }

    return nil;
}
-(BOOL)signWithUsername:(NSString *)username withPassword:(NSString *)password isSignup:(BOOL)isSignUp;
{
    NSString *baseUrl = @"Index/Register/apiRegister";
    NSString *url = [NSString stringWithFormat:@"http://www.kanpet.cn/%@?username=%@&password=%@",baseUrl,username,password];
    NSDictionary *nstr = [self getJsonWithUrl:url];
    if (nstr) {
        NSInteger flog = [[nstr objectForKey:@"status"] integerValue];
        return flog;
    }
    return NO;
}
//vedio URL
-(NSString *)getVedioUrlWithShardID:(NSString *)shardID withUK:(NSString *)uk
{
    NSString *url = [NSString stringWithFormat:@"https://pcs.baidu.com/rest/2.0/pcs/device?method=liveplay&shareid=%@&uk=%@",shardID,uk];
    NSDictionary *nstr = [self getJsonWithUrl:url];
    if (nstr) {
        int error = [[nstr valueForKey:@"error_code"] intValue];
        if(error){
            return [self getErrorStrWithCode:error];
        }else{
            return [nstr objectForKey:@"url"];
        }
    }
    return nil;
}
//缩略图URl
-(NSString *)getImageUrlWithShardID:(NSString *)shardID withUK:(NSString *)uk
{
    NSString *url = [NSString stringWithFormat:@"https://pcs.baidu.com/rest/2.0/pcs/device?method=thumbnail&shareid=%@&uk=%@",shardID,uk];
    NSDictionary *nstr = [self getJsonWithUrl:url];
    if (nstr) {
        int error = [[nstr valueForKey:@"error_code"] intValue];
        if(error){
            return [self getErrorStrWithCode:error];
        }else{
            NSArray *data = [nstr valueForKey:@"list"];
            return [data[0] valueForKey:@"url"];
        }
    }
    return nil;
}


- (NSString *)getErrorStrWithCode:(int)errorcode
{
    NSString *errorInfo;
    switch (errorcode) {
        case 31023:
            errorInfo = @"访问的参数错误";
            break;
        case 31021:
            errorInfo = @"哦哦，阁下网络出错了";
            break;
        case 31353:
            errorInfo = @"哦哦，设备不存在";
            break;
        case 31354:
            errorInfo = @"哦哦，阁下没有访问该设备的权限";
            break;
        
        case 31365:
            errorInfo = @"哦哦，当前设备没有分享直播";
            break;
        case 4:
            errorInfo = @"访问的参数错误";
            break;
        default:
            errorInfo = @"没有信息";
            break;
    }
    return errorInfo;
}
@end
