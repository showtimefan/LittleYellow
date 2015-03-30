//
//  UtilsMacro.h
//  newgame
//
//  Created by shichangone on 9/4/14.
//  Copyright (c) 2014 ngds. All rights reserved.
//

#ifndef newgame_UtilsMacro_h
#define newgame_UtilsMacro_h

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Heights

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_3_5_INCH ((NSUInteger)([[UIScreen mainScreen] bounds].size.height - 480) ? NO:YES)

///////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Strings

#define PARSE_NULL_STR(nsstr) nsstr ? nsstr : @""


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//version

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//iOS版本首位数字 比如5.01 -> 5
#define IosVersionFirstValue ([[[UIDevice currentDevice] systemVersion] intValue])

//iOS7之后
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define NG_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define NG_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font] : CGSizeZero;
#endif

// 设备屏宽
#define DEVICE_WIDTH [[UIScreen mainScreen] applicationFrame].size.width
// 设备屏高
#define DEVICE_HEIGHT [[UIScreen mainScreen] applicationFrame].size.height
// 设笽全屏高
#define DEVICE_FULL_HEIGHT  [[UIScreen mainScreen] bounds].size.height
// 设备全屏宽
#define DEVICE_FULL_WIDTH [[UIScreen mainScreen] bounds].size.width

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Color
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
                                      green:((float)((hex & 0xFF00) >> 8)) / 255.0 \
                                       blue:((float)(hex & 0xFF)) / 255.0 \
                                      alpha:1]

//float equal
#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//Blocks
typedef void (^NGBlock)();
typedef void (^NGSenderBlock)(id sender);
typedef void (^NGArrayBlock)(NSArray* array);
typedef void (^NGIndexBlock)(NSUInteger index);
typedef void (^NGDictionaryBlock)(NSDictionary* dictionary);
typedef void (^NGErrorBlock)(NSInteger errorCode, NSString* error);
typedef void (^NGArrayOfPageBlock)(NSArray* array, NSUInteger allCount);

//下载状态
typedef NS_OPTIONS(NSUInteger, NGDownloadState) {
    NGDownloadStatePause  = 1 << 0,
    NGDownloadStateLoding  = 1 << 1,
    NGDownloadStateFinish  = 1 << 2,
    NGDownloadStateError   = 1 << 3,
    NGDownloadStateReady   = 1 << 4,
    NGDownloadNone         = 1 << 5,
};

typedef NS_ENUM(NSUInteger, NGAllGameType) {
    NGAllGameTypeSort, //排行榜
    NGAllGameTypeClasses, //分类
};

typedef NS_ENUM(NSUInteger, NGNewGameType) {
    NGNewGameTypeSuggest, //推荐
    NGNewGameTypeSpecial, //专题
};

typedef NS_ENUM(NSUInteger, NGDownLoadViewState) {
    NGDownLoadViewStateLoading,//正在下载
    NGDownLoadViewStateFinish, //已下载
    NGDownLoadViewStateUpdate, //更新
};

typedef NS_ENUM(NSUInteger, NGDownloadCellFinishType) {
    NGDownloadCellFinishTypeUnInstall,//未安装
    NGDownloadCellFinishTypeInstalled, //已安装
};
#endif

