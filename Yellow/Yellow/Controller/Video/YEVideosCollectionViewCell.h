//
//  YEVideosCollectionViewCell.h
//  Yellow
//
//  Created by Coffee on 15/3/25.
//  Copyright (c) 2015年 LSZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YEVideosCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *optBtn;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (nonatomic) NSInteger curIndex;
@end
