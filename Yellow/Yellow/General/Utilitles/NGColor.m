//
//  NGColor.m
//  NewGamePad
//
//  Created by chisj on 15/3/19.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "NGColor.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hex & 0xFF00) >> 8)) / 255.0 \
blue:((float)(hex & 0xFF)) / 255.0 \
alpha:1]


@implementation NGColor

+ (UIColor *)colorOrange {
    return HEXCOLOR(0xff9900);
}

+ (UIColor *)colorBlue {
    return HEXCOLOR(0x0098FE);
}

//灰色背景
+ (UIColor *)colorGray {
    return RGBCOLOR(205, 205, 205);
}

@end
