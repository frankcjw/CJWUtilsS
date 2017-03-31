//
//  AppInfoManager.m
//  Album
//
//  Created by cen on 23/6/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import "AppInfoManager.h"
NSDictionary *infoDictionary;
@implementation AppInfoManager


+(void)initialize{
    infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
}

+(NSString *)getBundleId{
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];

}

+(NSString *)getVersion{
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)getBuild{
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

+(NSString *)getName{
//    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    DDLogDebug(@"%@",infoDictionary);
    return @"相聚云相册";
}

+(NSString *)getAppCode{
    return @"20140819";
}

+(NSString *)getUrlScheme{
    return @"xiangju://www.myclan.tv";
}

+(BOOL)hasLogin{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [userDefault objectForKey:@"logined"];
    if ([isLogin isEqualToString:@"yes"]) {
        return YES;
    }else{
        return NO;
    }
}

@end
