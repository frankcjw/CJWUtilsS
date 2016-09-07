//
//  AppInfoManager.h
//  Album
//
//  Created by cen on 23/6/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SessionKey  [AppInfoManager getSessionKey]
#define MemberId    [AppInfoManager getMemberId];
//系统信息
/**
 *  获取应用信息
 *  主要提供版本,memberId,SessionKey;
 *  不需要主动设置
 */
@interface AppInfoManager : NSObject

/**
 *  获取版本信息
 *
 *  @return 版本
 */
+(NSString *)getVersion;

/**
 *  获取编译版本
 *
 *  @return 获取编译版本
 */
+(NSString *)getBuild;

/**
 *  获取应用名称
 *
 *  @return 获取应用名称
 */
//+(NSString *)getName;

/**
 *  获取更新号(暂时没使用)
 *
 *  @return 获取更新号
 */
+(NSString *)getAppCode;

/**
 *  获取UrlScheme
 *
 *  @return UrlScheme
 */
+(NSString *)getUrlScheme;

@end
