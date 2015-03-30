//
//  NGBaseViewController.h
//  NewGamePad
//
//  Created by chisj on 14/12/26.
//  Copyright (c) 2014年 NG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGBaseViewController : UIViewController

@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property(strong, nonatomic) UIActivityIndicatorView *indicatorView;
- (void)actionLeft;
- (void)actionRight;

- (UIImage*)tabImage;
@end
