//
//  KanpetDataSouse.h
//  KanpetApp
//
//  Created by nichalos on 14/9/20.
//  Copyright (c) 2014年 kanpet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KanpetDataSouse : NSObject

//创建单例
+ (KanpetDataSouse *)sharedDataSource;

-(NSDictionary *)getJsonWithUrl:(NSString *)url;
-(NSArray *)loginWithUsername:(NSString *)username withPassword:(NSString *)password isSignup:(BOOL)isSignUp;
-(BOOL)signWithUsername:(NSString *)username withPassword:(NSString *)possword isSignup:(BOOL)isSignUp;
-(NSString *)getVedioUrlWithShardID:(NSString *)shardID withUK:(NSString *)uk;
-(NSString *)getImageUrlWithShardID:(NSString *)shardID withUK:(NSString *)uk;
@end
