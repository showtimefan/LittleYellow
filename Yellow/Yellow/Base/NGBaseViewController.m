//
//  NGBaseViewController.m
//  NewGamePad
//
//  Created by chisj on 14/12/26.
//  Copyright (c) 2014年 NG. All rights reserved.
//

#import "NGBaseViewController.h"
#import "UtilsMacro.h"
#import "AppMacro.h"
#import "Masonry.h"

@interface NGBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation NGBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initNavBar];
    [self createIndicatorView];

    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.216f green:0.275f blue:0.361f alpha:1.00f];

}

- (UIImage*)tabImage {
    return nil;
}

- (void)createIndicatorView {
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview: self.indicatorView];
    __weak typeof(self) weakSelf = self;
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view).centerOffset(CGPointMake(-5, 10));
    }];
}

- (void)initNavBar {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    float navHeight =  64;
    float navButtonOriginY =  25;
    
    _navView = [[UIView alloc] initWithFrame:CGRectZero];
    _navView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_navView];
    _navView.backgroundColor = NAVIGATION_BAR_COLOR;
    
    NSMutableArray * tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_navView(superview)]" options:0 metrics:nil views:@{@"_navView":_navView, @"superview":self.view}]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[_navView(%f)]", navHeight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_navView)]];
    [self.view addConstraints:tempConstraints];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    [_navView addSubview:_titleLabel];
    tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_titleLabel]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_titleLabel(34)]", navButtonOriginY] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [_navView addConstraints:tempConstraints];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectZero;
    _leftButton.translatesAutoresizingMaskIntoConstraints = NO;
    _leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_navView addSubview:_leftButton];
    tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_leftButton(70)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_leftButton(34)]", navButtonOriginY] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton)]];
    [_navView addConstraints:tempConstraints];
//    if (self.navigationController.viewControllers.count > 1) {
        [_leftButton setImage:[UIImage imageNamed:@"导航栏_返回"] forState:UIControlStateNormal];
        [_leftButton setImage:[UIImage imageNamed:@"导航栏_返回_点击态"] forState:UIControlStateHighlighted];
//    }
    
    //增加点击区域面积
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = CGRectZero;
    btnLeft.translatesAutoresizingMaskIntoConstraints = NO;
    btnLeft.backgroundColor = [UIColor clearColor];
    [_navView addSubview:btnLeft];
    [btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navView.mas_left);
        make.top.equalTo(_navView.mas_top).offset(navButtonOriginY);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(34);
    }];
    [btnLeft addTarget:self action:@selector(actionLeft) forControlEvents:UIControlEventTouchUpInside];

    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectZero;
    _rightButton.translatesAutoresizingMaskIntoConstraints = NO;
    _rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [_navView addSubview:_rightButton];
    tempConstraints = [NSMutableArray array];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightButton(70)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightButton)]];
    [tempConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[_rightButton(34)]", navButtonOriginY] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightButton)]];
    [_navView addConstraints:tempConstraints];
    
    [_leftButton addTarget:self action:@selector(actionLeft) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(actionRight) forControlEvents:UIControlEventTouchUpInside];
}


- (void)actionLeft {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    //如果是rootView,同时是model页面
    if(self.parentViewController != nil || self.navigationController != nil) {
        [self dismissViewControllerAnimated:YES completion:^{
            nil;
        }];
    }

}

- (void)actionRight {

}

//处理自定义返回键后系统滑动返回失效的问题
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self isRootViewController]) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Private
- (BOOL)isRootViewController {
    return (self == self.navigationController.viewControllers.firstObject);
}


@end
