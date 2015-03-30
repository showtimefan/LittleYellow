//
//  AppMacro.h
//  newgame
//
//  Created by shichangone on 9/4/14.
//  Copyright (c) 2014 ngds. All rights reserved.
//

#ifndef newgame_AppMacro_h
#define newgame_AppMacro_h

#import "UtilsMacro.h"

//----------------------------------内外网设置--------------------------------------
#define SIMULATE_SERVER 1
#define OUTER_SERVER 2
#define SERVER OUTER_SERVER

#if (SERVER == OUTER_SERVER)
//外网
#define API_BASE_URL @"http://api.newgamepad.com/v2/"
#define API_PHOTO_URL @"http://api.newgamepad.com/v2/images"
#define API_WEB_URL @"http://api.newgamepad.com/v2/"
#define API_SDK_URL @"http://api.newgamepad.com/v2/"

#define USER_HELP_URL @"http://newgamepad.com/faq/newios"
#define API_FORUM_URL @"http://api.newgamer.com/v1/"
#define API_FORUM_WEB_URL @"http://m.newgamer.com/"
#define API_GIFT_WEB_URL @"http://api.newgamepad.com/v2/"
#define USER_GET_PASSWORD @"http://newgamepad.com/users/password"
#elif (SERVER == SIMULATE_SERVER)
//内网
#define API_BASE_URL @"http://dev.api.newgamepad.com:8000/v2/"
#define API_WEB_URL @"http://dev.newgamepad.com:8000/"
#define API_PHOTO_URL @"http://dev.api.newgamepad.com:8000/v2/images"
#define API_FORUM_URL @"http://dev.api.newgamer.com:8000/v1/"
#define API_FORUM_WEB_URL @"http://dev.m.newgamer.com:8000/"
#define API_GIFT_WEB_URL @"http://dev.api.newgamepad.com:8000/v2/"
#define USER_HELP_URL @"http://newgamepad.com/faq/newios"
#define USER_GET_PASSWORD @"http://dev.newgamepad.com:8000/users/password"
#endif

#define APP_ClientId @"5"
#define APP_ClientSecret @"Ba1GL4YMAIkKjBfPxfMwndG4xio1Jmuf"

//----------------------------------升级内外网设置--------------------------------------
#define UPDATE_URL @"http://api.newgamepad.com/v1/pkgs"

//----------------------------------颜色设置--------------------------------------
//导航栏颜色
#define NAVIGATION_BAR_COLOR HEXCOLOR(0xff9900)

#define MAIN_PAGE_BG_COLOR RGBCOLOR(244,247,254)

//TabBar Colors
#define TABBAR_COLOR HEXCOLOR(0x272b34)
#define TABBAR_TEXT_COLOR HEXCOLOR(0X595C61)
#define TABBAR_TEXT_HIGHLIGHT_COLOR HEXCOLOR(0X4ACCFE)

//登录注册填写邮箱的tip文字颜色
#define LOGIN_TEXT_FIELD_PLACEHOLD_COLOR [UIColor colorWithRed:0.396f green:0.412f blue:0.424f alpha:1.00f]

#define VIEWCONTROLLER_BACK_COLOR HEXCOLOR(0x3f4446)
//#define VIEWCONTROLLER_BACK_COLOR HEXCOLOR(0x34465c)
//下载右侧底色
#define VIEW_DOWNLOAD_BACK_COLOR HEXCOLOR(0x2f3336)

//文字颜色
#define TITLE_TEXT_COLOR HEXCOLOR(0X3a3a3a)
#define CONTENT_TEXT_COLOR HEXCOLOR(0x79797a)

//光标颜色(黄色)
#define TEXT_HIGHT_YELLOW [UIColor colorWithRed:0.996f green:0.898f blue:0.337f alpha:1.00f]
//----------------------------------高度设置--------------------------------------
//导航栏加状态栏高度
#define NAVIGATION_ADN_STATUS_BAR_HEIGHT 64
//键盘高度
#define SYS_KYEBOARD_HEIGHT 216
#define SYS_CHINESE_KYEBOARD_HEIGHT 252
///中文输入区域高度
#define SYS_CHINESE_KEYBOARD_TOP_HEIGHT 36

#define VIEW_DOWNLOAD_BOTTOM_HEIGHT 37
#define VIEW_DOWNLOAD_TIP_OFFSET_Y 30
//----------------------------------游戏页面--------------------------------------
#define All_VIEW_ITEM_SPACE 15  //游戏单元格间距

//----------------------------------请求配置--------------------------------------
#define GET_DATE_INIT_NUM 20
#define GET_DATE_MORE_NUM 20
//#define APP_VIEW_CONTENT_HEIGHT =
#define GET_COMMENT_MORE_NUM  20 //游戏评论每页加载20条

//下载管理
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]
#define DOWNLOAD_DIRECTORY [DocumentsDirectory stringByAppendingPathComponent:@"/package/"]
#define DOWNLOAD_CACHE_DIRECTORY [DocumentsDirectory stringByAppendingPathComponent:@"/Incomplete/"]

//友盟
#define UMENG_APPKEY @"538ee67256240ba4a8025bf2"


//默认图片
#define IMAGE_PLACEHOLDER_ICON [UIImage imageNamed:@"默认图标"]
#define IMAGE_PLACEHOLDER_LANDSCAPE [UIImage imageNamed:@"默认图片-长方形"]

#endif
