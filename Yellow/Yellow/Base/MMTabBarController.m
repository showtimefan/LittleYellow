//
//  MMTabBarController.m
//  91BeautyClient
//
//  Created by jackie on 14-1-9.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import "MMTabBarController.h"
#import "UtilsMacro.h"
#import "NGAddtions.h"
#import "NGBaseViewController.h"

#define TAG_OFFSET 10

@interface MMTabBarController ()

@end

@implementation MMTabBarController {
    UIImageView* _tabBarView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tabBarView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:HEXCOLOR(0x000000)]];
    _tabBarView.frame = self.tabBar.bounds;
    _tabBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tabBarView.userInteractionEnabled = YES;
    [self.tabBar addSubview:_tabBarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.selectedViewController beginAppearanceTransition: YES animated: animated];
    [self.tabBar bringSubviewToFront:_tabBarView];
    [super viewWillAppear:animated];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers:viewControllers];
    
    [self layoutTabs];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    [super setViewControllers:viewControllers animated:animated];
    
    [self layoutTabs];
}


- (void)layoutTabs {
    [_tabBarView removeAllSubviews];
    
    UIImage* highlightImage = [UIImage imageWithColor:HEXCOLOR(0x222222)];
    
    for (UINavigationController* navController in self.viewControllers) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSInteger index = [self.viewControllers indexOfObject:navController];
        button.tag = index + TAG_OFFSET;
        button.frame = CGRectMake(index * (_tabBarView.width / (float)self.viewControllers.count), 0, (_tabBarView.width / (float)self.viewControllers.count), _tabBarView.height);
        [button setBackgroundImage:highlightImage forState:UIControlStateSelected];
        [button setBackgroundImage:highlightImage forState:(UIControlStateHighlighted | UIControlStateSelected)];

        [button addTarget:self action:@selector(actionSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:button];
        
        NGBaseViewController* topViewController = navController.viewControllers[0];
        [button setImage:topViewController.tabImage forState:UIControlStateNormal];
        [button setImage:topViewController.tabImage forState:UIControlStateHighlighted];
        [button setImage:topViewController.tabImage forState:UIControlStateHighlighted | UIControlStateSelected];

        if (index == 0) {
            button.selected = YES;
        }
    }
}


- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    if (selectedViewController != self.selectedViewController) {
        UIButton* preButton = (UIButton*)[_tabBarView viewWithTag:([self.viewControllers indexOfObject:self.selectedViewController] + TAG_OFFSET)];
        preButton.selected = NO;
        UIButton* button = (UIButton*)[_tabBarView viewWithTag:([self.viewControllers indexOfObject:selectedViewController] + TAG_OFFSET)];
        button.selected = YES;
    }
    
    [super setSelectedViewController:selectedViewController];
}

- (void)actionSelect:(UIButton*)button {
    [self.tabBar bringSubviewToFront:_tabBarView];
    UIViewController* viewController = self.viewControllers[button.tag - TAG_OFFSET];

    
    BOOL shouldSelect = YES;
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        shouldSelect = [self.delegate tabBarController:self shouldSelectViewController:viewController];
    }
    
    if (!shouldSelect) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:viewController];
    }
    
    self.selectedViewController = viewController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.selectedViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController beginAppearanceTransition:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.selectedViewController endAppearanceTransition];
}


@end
