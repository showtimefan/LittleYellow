//
//  NGCommonAPI.h
//  newgame
//
//  Created by Coffee on 14-5-7.
//  Copyright (c) 2014年 ngds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UtilsMacro.h"
#include <sys/sysctl.h>
#include <sys/utsname.h>

@interface NGCommonAPI : NSObject

+ (NSString*)generateGUID;

+ (CGSize)getImgSize:(UIImage *)image customWidth:(CGFloat)customWidth;

+ (void)alert:(NSString *)message;

+(BOOL)isJailbroken;

+ (BOOL)isValidEmail:(NSString *)checkString;

//发表时间显示文字
+ (NSString*)getStingByDate:(NSDate*)date;

//@"yyyy-MM-dd"
+ (NSString *)getStingByTimeString:(NSString*)timeStr;

//获取下载剩余时间
+ (NSString *)getStringByRemainTime:(NSNumber *)time;

//根据字节数返回可以阅读的大小
+ (NSString*)getSizeFormatByByt:(NSNumber *)byte;


+ (NSUInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2;
//是否是登陆状态
+ (BOOL)isLogin;
+ (void)logout;

//是否第一次登陆
+ (BOOL)isFirstLogin;
+ (void)setFirstLogin:(BOOL)isFirstLogin;

+ (BOOL)isEmpytString:(NSString *)aString;
//用户是否登录
+ (NSString *)userToken;
+ (void)setUserToken:(NSString *)userToken;

//用户名
+ (NSString *)userName;
+ (void)setUserName:(NSString *)userName;

+ (NSString *)getUUID;
+ (NSString *)platformString;
@end
