//
//  NGAppPreference.h
//
//  Created by coffee on 21/4/14.
//
//

#import <Foundation/Foundation.h>

@interface NGAppPreference: NSObject

@property (nonatomic, strong) NSDictionary *userInfo;   //当前登录账户信息
@property (nonatomic, strong) NSArray *adGames;//广告位内容缓存
@property (nonatomic, strong) NSArray *hotSearchArray;//热门搜索缓存
@property (nonatomic, strong) NSDictionary *rankGameDic; ////排行版缓存
@property (nonatomic, strong) NSArray *selectionGameArray;//精选缓存
@property (nonatomic, strong) NSArray *categorieGameArray; //分类缓存
@property (nonatomic, strong) NSDictionary *gameInfos;//游戏详情缓存
@property (nonatomic, strong) NSArray *ignoreGameArray; //忽略列表缓存
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *lastAccout; //上一次登录的账号
@property (nonatomic, strong) NSDictionary *cacheForumPost; //发帖草稿
@property (nonatomic) BOOL gameUpdateAlertValid;

@property (nonatomic, strong) NSString *notificationMessageTime;

+ (instancetype)sharedInstance;

- (void)setPreferenceValue:(NSObject*)preference forKey:(NSString*)key;

- (instancetype)preferenceValueForKey:(NSString*)key;

@end
