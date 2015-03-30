//
//  NGSpecialCollectionCell.m
//  NewGamePad
//
//  Created by Coffee on 15/1/5.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "YEPhotosCollectionCell.h"
#import "UIImage+NGAdditions.h"

@implementation YEPhotosCollectionCell

- (void)awakeFromNib {
    // Initialization code
    self.photoImageView.layer.masksToBounds = YES;
//    self.photoImageView.layer.cornerRadius = 5;
}

+ (NSInteger)cellHeight {
    return 170;
}
@end
