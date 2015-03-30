//
//  UINavigationController+NGAdditions.m
//  newgame
//
//  Created by Coffee on 14-7-7.
//  Copyright (c) 2014年 ngds. All rights reserved.
//

#import "UINavigationController+NGAdditions.h"

//@implementation UINavigationBar (CustomHeight)
//- (CGSize)sizeThatFits:(CGSize)size {
//    // Change navigation bar height. The height must be even, otherwise there will be a white line above the navigation bar.
//    CGSize newSize = CGSizeMake(self.frame.size.width, 44);
//    return newSize;
//}
//
//-(void)layoutSubviews {
//    [super layoutSubviews];
//
//    CGRect barFrame = self.frame;
//    barFrame.size.height = 44;
//    self.frame = barFrame;
//
//    // Make items on navigation bar vertically centered.
//    int i = 0;
//    for (UIView *view in self.subviews) {
//        if (i == 0)
//            continue;
//        float centerY = self.bounds.size.height / 2.0f;
//        CGPoint center = view.center;
//        center.y = centerY;
//        view.center = center;
//    }
//}
//
//@end

//@implementation UINavigationController (OrientationFix)
//
////- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
////    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
////}
////
////- (BOOL)shouldAutorotate {
////    return YES;
////}
////
////- (NSUInteger)supportedInterfaceOrientations {
////    return UIInterfaceOrientationMaskLandscape;
////}
//
//-(BOOL)shouldAutorotate {
//    return [[self.viewControllers lastObject] shouldAutorotate];
//}
//
//-(NSUInteger)supportedInterfaceOrientations {
//    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
//}
//@end
//
//@implementation UIViewController (OrientationFix)
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
//}
//
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskAll;
//}
//
//@end
//
//
//@implementation UIImagePickerController (OrientationFix)
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
//}
//
//- (BOOL)shouldAutorotate {
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//@end