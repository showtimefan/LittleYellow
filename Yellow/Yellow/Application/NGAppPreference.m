//
//  NGSDKPreference.m
//  NGSDK
//
//  Created by shichangone on 21/4/14.
//
//

#import "NGAppPreference.h"

@interface NGAppPreference ()

@property (nonatomic, strong) NSMutableDictionary* preference;
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSMutableDictionary *nocachePreference;

@end

@implementation NGAppPreference

+ (instancetype)sharedInstance {
    static NGAppPreference *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString* directory = [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Application Support"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:directory]) {
            [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        _preference = [NSMutableDictionary dictionary];
        _nocachePreference = [NSMutableDictionary new];
        _path = [directory stringByAppendingPathComponent:@"appPrefence.plist"];
        if (![fileManager fileExistsAtPath:_path]) {
            [_preference writeToFile:_path atomically:YES];
        } else {
            [_preference setDictionary:[NSDictionary dictionaryWithContentsOfFile:_path]];
        }
    }
    return self;
}

- (void)_writeCache {
    if (![_preference writeToFile:_path atomically:NO]) {
        NSLog(@"write failed");
    }
}

- (void)updateSetting {
    //防止不断写入
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_writeCache) object:nil];
    [self performSelector:@selector(_writeCache) withObject:nil afterDelay:0.01f];
}


- (void)setUserInfo:(NSDictionary *)userInfo {
    if (userInfo) {
        _preference[@"userInfo"] = userInfo;
    } else {
        [_preference removeObjectForKey:@"userInfo"];
    }
    [self updateSetting];
}

- (NSDictionary*)userInfo {
    return _preference[@"userInfo"];
}

//排行版缓存
- (void)setRankGameDic:(NSDictionary *)rankGameDic {
    if (rankGameDic) {
        _preference[@"rankGameDic"] = rankGameDic;
    } else {
        [_preference removeObjectForKey:@"rankGameDic"];
    }
    [self updateSetting];
}

- (NSDictionary*)rankGameDic {
    return _preference[@"rankGameDic"];
}

//热门搜索缓存
- (void)setHotSearchArray:(NSArray *)hotSearchArray {
    if (hotSearchArray) {
        _preference[@"hotSearchArray"] = hotSearchArray;
    } else {
        [_preference removeObjectForKey:@"hotSearchArray"];
    }
    [self updateSetting];
}

- (NSDictionary*)hotSearchArray {
    return _preference[@"hotSearchArray"];
}

- (void)setSelectionGameArray:(NSArray *)selectionGameArray {
    if (selectionGameArray) {
        _preference[@"selectionGameArray"] = selectionGameArray;
    } else {
        [_preference removeObjectForKey:@"selectionGameArray"];
    }
    [self updateSetting];
}

- (NSArray *)selectionGameArray {
    return _preference[@"selectionGameArray"];
}

- (void)setAdGames:(NSArray *)adGames {
    if (adGames) {
        _preference[@"adGames"] = adGames;
    } else {
        [_preference removeObjectForKey:@"adGames"];
    }
    [self updateSetting];
}

- (NSArray *)adGamefs {
    return _preference[@"adGames"];
}

//分类缓存
- (void)setCategorieGameArray:(NSArray *)categorieGameArray {
    if (categorieGameArray) {
        _preference[@"categorieGameArray"] = categorieGameArray;
    } else {
        [_preference removeObjectForKey:@"categorieGameArray"];
    }
    [self updateSetting];
}

- (NSDictionary*)categorieGameArray {
    return _preference[@"categorieGameArray"];
}

- (void)setGameInfos:(NSDictionary *)gameInfos {
    if (gameInfos) {
        _nocachePreference[@"gameInfos"] = gameInfos;
    } else {
        [_nocachePreference removeObjectForKey:@"gameInfos"];
    }
    //[self updateSetting];
}

- (NSDictionary *)gameInfos {
    return _nocachePreference[@"gameInfos"];
}

//游戏忽略列表缓存
- (void)setIgnoreGameArray:(NSArray *)ignoreGameArray {
    if (ignoreGameArray) {
        _preference[@"ignoreGameArray"] = ignoreGameArray;
    } else {
        [_preference removeObjectForKey:@"ignoreGameArray"];
    }
    [self updateSetting];
}

- (NSArray *)ignoreGameArray {
    return _preference[@"ignoreGameArray"];
}

- (void)setAccessToken:(NSString *)accessToken {
    if (accessToken) {
        _preference[@"access_token"] = accessToken;
    }else {
        [_preference removeObjectForKey:@"access_token"];
    }

    [self updateSetting];
}

- (NSString*)accessToken {
    return _preference[@"access_token"];
}

- (void)setLastAccout:(NSString *)lastAccout {
    if (lastAccout) {
        _preference[@"last_account"] = lastAccout;
    }else {
        [_preference removeObjectForKey:@"last_account"];
    }

    [self updateSetting];
}

- (NSString*)lastAccout {
    return _preference[@"last_account"];
}

//发帖草稿保存
- (void)setCacheForumPost:(NSDictionary *)cacheForumPost {
    if (cacheForumPost) {
        _preference[@"cacheForumPost"] = cacheForumPost;
    }else {
        [_preference removeObjectForKey:@"cacheForumPost"];
    }
    
    [self updateSetting];
}

- (NSDictionary *)cacheForumPost {
    return _preference[@"cacheForumPost"];
}

- (void)setGameUpdateAlertValid:(BOOL)gameUpdateAlertValid {
    _preference[@"gameUpdateAlertValid"] = @(gameUpdateAlertValid);
    
    [self updateSetting];
}

- (BOOL)gameUpdateAlertValid {
    if (!_preference[@"gameUpdateAlertValid"]) {
        _preference[@"gameUpdateAlertValid"] = @(YES);
        //默认是开启
        return YES;
    }
    return [_preference[@"gameUpdateAlertValid"] boolValue];
}


- (void)setPreferenceValue:(NSDictionary*)preference forKey:(NSString*)key {
    if (preference) {
        _preference[key] = preference;
    } else {
        [_preference removeObjectForKey:key];
    }
    [self updateSetting];
}

- (instancetype)preferenceValueForKey:(NSString*)key {
    return _preference[key];
}

#pragma mark mesasge获取时间

- (NSString*)notificationMessageTime {
    return _preference[@"notificationMessageTime"];
}

- (void)setNotificationMessageTime:(NSString *)notificationMessageTime {
    if (notificationMessageTime) {
        _preference[@"notificationMessageTime"] = notificationMessageTime;
    }else {
        [_preference removeObjectForKey:@"notificationMessageTime"];
    }
    
    [self updateSetting];
}
@end

