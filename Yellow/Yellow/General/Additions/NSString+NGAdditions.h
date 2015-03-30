//
//  NSString+NGAdditions.h
//  newgame
//
//  Created by shichangone on 16/4/14.
//  Copyright (c) 2014 ngds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NGAdditions)

- (NSString*)md5Hash;
- (NSString*)sha1Hash;

+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding;

- (id)jsonValue;
@end

@interface  NSString (Email)

- (BOOL)isEmailValid;

@end

@interface NSString (Check)

- (BOOL)isEmpty;
@end


@interface NSString (NGImageThumb)
- (NSURL *)toURL;
- (NSString *)toThumbImageURL128;
- (NSString *)toThumbImageURL240;
- (NSString *)toThumbImageURL320;
- (NSString *)toThumbImageURL480;
- (NSString *)toThumbImageURL640;
- (NSString *)toThumbImageURL720;
- (NSString *)toThumbImageURL960;
- (NSString *)toThumbImageURL1024;
- (NSString *)toThumbImageURL1280;
@end