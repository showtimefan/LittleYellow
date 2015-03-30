//
//  NSString+NGAdditions.m
//  newgame
//
//  Created by shichangone on 16/4/14.
//  Copyright (c) 2014 ngds. All rights reserved.
//

#import "NSString+NGAdditions.h"
#import <CommonCrypto/CommonCrypto.h>
#import "NSData+NGAdditions.h"
#import "NSJSONSerialization+NGAdditions.h"

@implementation NSString (NGAdditions)

- (NSString*)md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}

- (NSString*)sha1Hash {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding {
    return [[NSString alloc] initWithData:data encoding:encoding];
}

- (id)jsonValue {
    return [NSJSONSerialization JSONObjectWithNString:self];
}

@end


@implementation  NSString (Email)

- (BOOL)isEmailValid {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end

@implementation NSString (Check)

- (BOOL)isEmpty {
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([temp length]) {
        return NO;
    }else {
        return YES;
    }
}

@end


@implementation NSString (NGImageThumb)
- (NSURL *)toURL {
    return [NSURL URLWithString:self ];
}
- (NSString *)toThumbImageURL128 {
    return [self stringByAppendingFormat:@"@%@", @"w128"];
}
- (NSString *)toThumbImageURL240 {
    return [self stringByAppendingFormat:@"@%@", @"w240"];
}
- (NSString *)toThumbImageURL320 {
    return [self stringByAppendingFormat:@"@%@", @"w320"];
}
- (NSString *)toThumbImageURL480 {
    return [self stringByAppendingFormat:@"@%@", @"w480"];
}
- (NSString *)toThumbImageURL640 {
    return [self stringByAppendingFormat:@"@%@", @"w640"];
}
- (NSString *)toThumbImageURL720 {
    return [self stringByAppendingFormat:@"@%@", @"w720"];
}
- (NSString *)toThumbImageURL960 {
    return [self stringByAppendingFormat:@"@%@", @"w960"];
}
- (NSString *)toThumbImageURL1024 {
    return [self stringByAppendingFormat:@"@%@", @"w1024"];
}
- (NSString *)toThumbImageURL1280 {
    return [self stringByAppendingFormat:@"@%@", @"w1280"];
}

@end