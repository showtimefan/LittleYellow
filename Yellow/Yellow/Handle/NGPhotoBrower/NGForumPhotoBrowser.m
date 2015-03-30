//
//  BCPhotoBrowser.m
//  91BeautyClient
//
//  Created by jackie on 14-1-6.
//  Copyright (c) 2014年 nd. All rights reserved.
//

#import "NGForumPhotoBrowser.h"
#import "UIView+NGAdditions.h"

@interface MWPhotoBrowser()

- (void)updateNavigation;
- (NSUInteger)numberOfPhotos;
- (void)setControlsHidden:(BOOL)hidden animated:(BOOL)animated permanent:(BOOL)permanent;

@end

@implementation NGForumPhotoBrowser{
	UIView * _backPageView;
	UIView * _curPageView;
}

-(void)viewDidLoad{
	[super viewDidLoad];

    [self setControlsHidden:YES animated:NO permanent:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

//考虑横屏情况,该函数不能在viewDidLoad调用需放入viewWillAppear
-(void)initCustomIndexView {
	_backPageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 2)];
	_backPageView.backgroundColor = [UIColor colorWithRed:54.0/255.0 green:54.0/255.0 blue:54.0/255.0 alpha:1.0];
	_backPageView.bottom = self.view.bottom;
	[self.view addSubview:_backPageView];

    if ([self numberOfPhotos]) {
        _curPageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width/ [self numberOfPhotos], 2)];
    }else {
        _curPageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 2)];
    }

	_curPageView.backgroundColor = [UIColor colorWithRed:0.992f green:0.596f blue:0.157f alpha:1.00f];
	_curPageView.bottom = self.view.bottom;
	[self.view addSubview:_curPageView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self initCustomIndexView];
    //	self.navigationController.navigationBarHidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

//	self.navigationController.navigationBarHidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                        duration:(NSTimeInterval)duration{

    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _curPageView.bottom = self.view.width;
        _curPageView.width = self.view.height/ [self numberOfPhotos];
        _backPageView.bottom = self.view.width;
    }else {
        _curPageView.bottom = self.view.height;
        _curPageView.width = self.view.width/ [self numberOfPhotos];
        _backPageView.bottom = self.view.height;
    }
}

- (void)updateNavigation{
	[super updateNavigation];


//    [self setCurrentPhotoIndex:1];
	if ([self numberOfPhotos] > 1) {
		_curPageView.left = self.currentIndex * _curPageView.width;
    }
}

- (void)toggleControls{
    [UIApplication sharedApplication].statusBarHidden = NO;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
	[self dismissViewControllerAnimated:NO completion:nil];
}
@end