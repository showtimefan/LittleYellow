//
//  NGCommonAPI.m
//  newgame
//
//  Created by Coffee on 14-5-7.
//  Copyright (c) 2014年 ngds. All rights reserved.
//

#import "NGCommonAPI.h"
//#import "NGForumModel.h"
#import "NotificationMacro.h"
#import "NGAppPreference.h"

#define NG_GAME_STORE_APP_UUID  @"NG_GAME_STORE_APP_UUID"


@implementation NGCommonAPI
+ (NSString*)generateGUID {
    return CFBridgingRelease(CFUUIDCreateString(NULL, CFUUIDCreate(NULL)));
}

+ (void)alert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:nil];
    [alert setMessage:message];
    [alert addButtonWithTitle:NSLocalizedString(@"ok",@"确定")];
    [alert show];
}

//图片按照固定宽度返回尺寸大小
+ (CGSize)getImgSize:(UIImage *)image customWidth:(CGFloat)customWidth {
    //得到比例
    float rate=(customWidth/image.size.width);
    return CGSizeMake(customWidth, (image.size.height*rate));
}

+(BOOL)isJailbroken {
    BOOL bCydia = NO;
    NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    bCydia = [[UIApplication sharedApplication] canOpenURL:url];

    if (!bCydia) {
        return NO;
    }

    BOOL  bAppsync = bAppsync = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/appsync.plist" isDirectory:nil];
    if (!bAppsync) {
        bAppsync = [[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/DynamicLibraries/AppSync.plist" isDirectory:nil];
    }

    if (bAppsync == NO)
    {
        NSError *err;
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/private/var/lib/dpkg/info" error:&err];

        for (int i = 0; i < files.count; i++)
        {
            NSString *fname = [files objectAtIndex:i];
            if ([fname rangeOfString:@"appsync" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                bAppsync = YES;
                break;
            }
        }
    }
    if (bAppsync == NO)
    {
        NSError *err;
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/var/lib/dpkg/info" error:&err];

        for (int i = 0; i < files.count; i++)
        {
            NSString *fname = [files objectAtIndex:i];
            if ([fname rangeOfString:@"appsync" options:NSCaseInsensitiveSearch].location != NSNotFound)
            {
                bAppsync = YES;
                break;
            }
        }
    }

    return bAppsync == YES;

}

+ (BOOL)isValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (float)calculateFileSizeInUnit:(unsigned long long)contentLength {
    if(contentLength >= pow(1024, 3))
        return (float) (contentLength / (float)pow(1024, 3));
    else if(contentLength >= pow(1024, 2))
        return (float) (contentLength / (float)pow(1024, 2));
    else if(contentLength >= 1024)
        return (float) (contentLength / (float)1024);
    else
        return (float) (contentLength);
}


//游戏下载量描述
+ (NSString *)getStringByDownload:(NSNumber *)number {
    if ([number intValue] < 10000) {
        return [number stringValue];
    }

    float wanNumber= [number floatValue]/10000.0;
    return [NSString stringWithFormat:@"%.1f 万", wanNumber];
}

+ (NSString *)getStingByTimeString:(NSString*)timeStr
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStr.doubleValue];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString *)getStringByRemainTime:(NSNumber *)time {
    if ([time integerValue] < 0) {
        return @"";
    }

    int remainingTime = [time intValue];
    int hours = remainingTime / 3600;
    int minutes = (remainingTime - hours * 3600) / 60;
    int seconds = remainingTime - hours * 3600 - minutes * 60;

    NSString *timeFormat = @"";
    if (hours || minutes || seconds) {
        timeFormat = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    return timeFormat;
}

+ (NSString *)getReadableSpeedFromSpeed:(NSInteger)speed {
    if(speed >= pow(1024, 3)) {
        return [NSString stringWithFormat:@"%.2f GB/s", (float)(speed/(float)pow(1024, 3))];
    }else if(speed >= pow(1024, 2)) {
        return [NSString stringWithFormat:@"%.2f MB/s", (float)(speed/(float)pow(1024, 2))];
    }else if(speed >= 1024) {
        return [NSString stringWithFormat:@"%.2f KB/s", (float)(speed/(float)1024)];
    }else {
        return [NSString stringWithFormat:@"%.2f B/s", (float) (speed)];
    }
}

- (int)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return (int)[components day]+1;
}

//帖子时间显示规则
//15s前--刚刚
//16s~60s--1分钟前
//1分钟~2分钟--1分钟前 ，其他依次类推
//60分钟~120分钟--1小时前
//当天--显示具体时间，格式：16:23
//其他--显示具体时间，格式：2015-02-02
+ (NSString *)getStingByDate:(NSDate*)date
{
    NSTimeInterval late=[date timeIntervalSince1970]*1;


    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";

    NSTimeInterval betweenTime =now-late;

    //15S
    if (betweenTime<=15) {
        timeString = @"刚刚";
    }
    if (betweenTime>16 && betweenTime/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", betweenTime/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }

    if (betweenTime/3600>=1 && betweenTime/3600<=2) {
        timeString = @"1小时前";
    }

    NSInteger days = [NGCommonAPI daysBetween:dat and:[NSDate date]];
    if (days==0) {
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];
    }else {
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:date]];
    }


    return timeString;
}

+ (NSString*)getSizeFormatByByt:(NSNumber *)byte {
    NSString *temp = @"";

    if ([byte longValue] > 1024*1024*1024) {
        temp = [NSString stringWithFormat:@"%0.2f GB", [byte floatValue]/(1024*1024*1024)];
    }else if([byte longValue] > 1024*1024){
        temp = [NSString stringWithFormat:@"%0.2f MB", [byte floatValue]/(1024*1024)];
    }else if([byte longValue] > 1024) {
        temp = [NSString stringWithFormat:@"%0.2f KB", [byte floatValue]/1024];
    }

    return temp;
}


//获取可读的文件大小,用于下载更新页面显示
+ (NSString*)getFileSizeByByt:(NSNumber *)byte {
    NSString *temp = @"";

    if ([byte longLongValue] > 1024*1024*1024) {
        temp = [NSString stringWithFormat:@"%0.2f GB", [byte floatValue]/(1024*1024*1024)];
    }else if([byte longLongValue] > 1024*1024){
        temp = [NSString stringWithFormat:@"%0.0f MB", [byte floatValue]/(1024*1024)];
    }else if([byte longLongValue] > 1024) {
        temp = [NSString stringWithFormat:@"%0.0f KB", [byte floatValue]/1024];
    }

    return temp;
}

+ (NSNumber *)freeSpaceOnDisk {
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if (dictionary) {
        float freeSpace  = [[dictionary objectForKey: NSFileSystemFreeSize] floatValue];
        return @(freeSpace);
    } else {
        return  @0;
    }
}

+ (NSString *)calculateFreeSpaceOnDisk {
   NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if (dictionary) {
        float freeSpace  = [[dictionary objectForKey: NSFileSystemFreeSize] floatValue];
        return  [NGCommonAPI getFileSizeByByt:@(freeSpace)];
    } else {
        return  @"";
    }
}

+ (NSString *)calculateTotalSpaceOnDisk {
   NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if (dictionary) {
        float totalSpace = [[dictionary objectForKey: NSFileSystemSize] floatValue];
        return  [NGCommonAPI getFileSizeByByt:@(totalSpace)];
    } else {
        return  @"";
    }
}

+ (NSString *)calculateUsedSpaceOnDisk {
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if (dictionary) {
        float totalSpace = [[dictionary objectForKey: NSFileSystemSize] floatValue];
        float freeSpace  = [[dictionary objectForKey: NSFileSystemFreeSize] floatValue];
        return  [NGCommonAPI getFileSizeByByt:@(totalSpace-freeSpace)];
    } else {
        return  @"";
    }
}

+ (float)calculateUsedPercentSpaceOnDisk {
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    if (dictionary) {
        float totalSpace = [[dictionary objectForKey: NSFileSystemSize] floatValue];
        float freeSpace  = [[dictionary objectForKey: NSFileSystemFreeSize] floatValue];
        return (totalSpace-freeSpace)/totalSpace;
    } else {
        return  0.0;
    }
}

+ (NSString*)getDownloadNumDesByNumber:(NSNumber *)downloadNum {
    NSString * downNumDes = @"";
    NSInteger temp = [downloadNum integerValue];
    if (temp >= 10000) {
        downNumDes = [NSString stringWithFormat:@"%0.2fW", (float)temp/10000] ;
    }else {
        downNumDes = [downloadNum stringValue];
    }

    return downNumDes;
}

//是否第一次登陆
+ (BOOL)isFirstLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"isFirstLogin"]) {
        return YES;
    }

    return [[defaults objectForKey:@"isFirstLogin"] boolValue];
}

+ (void)setFirstLogin:(BOOL)isFirstLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isFirstLogin) forKey:@"isFirstLogin"];
    [defaults synchronize];
}

+ (NSUInteger)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return [components day];
}

//是否只在WIFI环境下下载
+ (BOOL)isWIFIDownloadOnly {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"WifiDownloadOnly"]) {
        return YES;
    }

    return [[defaults objectForKey:@"WifiDownloadOnly"] boolValue];
}

+ (void)setWIFIDownloadOnly:(BOOL)isWIFIDownloadOnly {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isWIFIDownloadOnly) forKey:@"WifiDownloadOnly"];
    [defaults synchronize];
}


//用户是否登录
+ (BOOL)isLogin {
    return [NGAppPreference sharedInstance].accessToken != nil;
}

+ (void)logout {
    [NGAppPreference sharedInstance].accessToken = nil;
    [NGAppPreference sharedInstance].userInfo = nil;
//    [[NGWebService sharedInstance] setAuthorizationHeaderWithToken:nil];
}

+ (BOOL)isEmpytString:(NSString *)aString {
    NSUInteger length = [aString length];
    unichar buffer[length];

    [aString getCharacters:buffer range:NSMakeRange(0, length)];

    BOOL bEmpyt = YES;
    for (NSUInteger i = 0; i < length; i++)
    {
        if (buffer[i] != '\n' && buffer[i] != ' ') {
            bEmpyt = NO;
        }

    }

    return bEmpyt;
}

//用户Token
+ (NSString *)userToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"userToken"]) {
        return @"";
    }
    return [defaults objectForKey:@"userToken"];
}

+ (void)setUserToken:(NSString *)userToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userToken forKey:@"userToken"];
    [defaults synchronize];
}

//用户名
+ (NSString *)userName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"userName"];
}

+ (void)setUserName:(NSString *)userName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:@"userName"];
    [defaults synchronize];
}

//是否接收有人回复我的消息
+ (BOOL)isReceiveNotifyUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"isReceiveNotifyUser"]) {
        return YES;
    }
    return [[defaults objectForKey:@"isReceiveNotifyUser"] boolValue];
}

+ (void)setReceiveNotifyUser:(BOOL)isReceiveNotifyUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isReceiveNotifyUser) forKey:@"isReceiveNotifyUser"];
    [defaults synchronize];
}

//是否接收系统消息
+ (BOOL)isReceiveNotifySys {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"isReceiveNotifySys"]) {
        return YES;
    }
    return [[defaults objectForKey:@"isReceiveNotifySys"] boolValue];
}

+ (void)setReceiveNotiySys:(BOOL)isReceiveNotifySys {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isReceiveNotifySys) forKey:@"isReceiveNotifySys"];
    [defaults synchronize];
}

//是否是最新版本
+ (BOOL)isNewestVersion {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:@"is_newest_version"] boolValue];
}

+ (void)setNewestVersion:(BOOL)isNewestVersion {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(isNewestVersion) forKey:@"is_newest_version"];
    [defaults synchronize];
}

//社区ID
+ (NSNumber *)forumInfoID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"forumInfoID"]) {
        return @50000000000034;
    }
    return [defaults objectForKey:@"forumInfoID"];
}

+ (void)setForumInfoID:(NSNumber *)forumInfoID {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:forumInfoID forKey:@"forumInfoID"];
    [defaults synchronize];
}


+ (NSString *)getUUID {
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:NG_GAME_STORE_APP_UUID];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:NG_GAME_STORE_APP_UUID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return uuid;
}

@end
