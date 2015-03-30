//
//  NGSpecialCollectionCell.h
//  NewGamePad
//
//  Created by Coffee on 15/1/5.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YEPhotosCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (nonatomic) NSInteger photoIndex;

@end
