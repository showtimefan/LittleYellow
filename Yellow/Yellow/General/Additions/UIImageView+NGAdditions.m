//
//  UIImageView+NGAdditions.m
//  NewGamePad
//
//  Created by chisj on 15/1/8.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "UIImageView+NGAdditions.h"

@implementation UIImageView (NGAdditions)

- (void)setFitToShowPeopleFace {
    self.clipsToBounds = YES;
    
    [self setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.contentMode =  UIViewContentModeScaleAspectFill;
}

@end
