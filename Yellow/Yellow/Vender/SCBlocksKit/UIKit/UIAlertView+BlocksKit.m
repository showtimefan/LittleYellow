//
//  UIAlertView+BlocksKit.m
//  BlocksKit
//

#import "NSArray+BlocksKit.h"
#import "UIAlertView+BlocksKit.h"
#import "NSObject+AssociatedObjects.h"

static char kAlertViewDelegaterKey;

@interface SCAlertViewDelegater : NSObject

@property (nonatomic, strong) NSMutableDictionary* handlers;

@end

@implementation SCAlertViewDelegater

- (id)init
{
    self = [super init];
    if (self) {
        _handlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	id key = @(buttonIndex);
	BKBlock buttonBlock = (self.handlers)[key];
	if (buttonBlock)
		buttonBlock();
}

@end

//#pragma mark Delegate
//
//@interface A2DynamicUIAlertViewDelegate : A2DynamicDelegate
//
//@end
//
//@implementation A2DynamicUIAlertViewDelegate
//
//- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
//	BOOL should = YES;
//	
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)])
//		should &= [realDelegate alertViewShouldEnableFirstOtherButton:alertView];
//	
//	BOOL (^block)(UIAlertView *) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		should &= block(alertView);
//	
//	return should;
//}
//
//- (void)alertViewCancel:(UIAlertView *)alertView {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(alertViewCancel:)])
//		[realDelegate alertViewCancel:alertView];
//	
//	id key = @(alertView.cancelButtonIndex);
//	BKBlock cancelBlock = (self.handlers)[key];
//	if (cancelBlock)
//		cancelBlock();
//}
//
//- (void)willPresentAlertView:(UIAlertView *)alertView {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(willPresentAlertView:)])
//		[realDelegate willPresentAlertView:alertView];
//	
//	void (^block)(UIAlertView *) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		block(alertView);
//}
//
//- (void)didPresentAlertView:(UIAlertView *)alertView {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(didPresentAlertView:)])
//		[realDelegate didPresentAlertView:alertView];
//	
//	void (^block)(UIAlertView *) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		block(alertView);
//}
//
//- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)])
//		[realDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
//	
//	void (^block)(UIAlertView *, NSInteger) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		block(alertView, buttonIndex);
//}
//
//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)])
//		[realDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
//	
//	void (^block)(UIAlertView *, NSInteger) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		block(alertView, buttonIndex);
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
//		[realDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
//	
//	void (^block)(UIAlertView *, NSInteger) = [self blockImplementationForMethod:_cmd];
//	if (block)
//		block(alertView, buttonIndex);
//	
//	id key = @(buttonIndex);
//	BKBlock buttonBlock = (self.handlers)[key];
//	if (buttonBlock)
//		buttonBlock();
//}
//
//@end

#pragma mark - Category

@implementation UIAlertView (BlocksKit)

#pragma mark Initializers

+ (id)alertViewWithTitle:(NSString *)title {
	return [self alertViewWithTitle:title message:nil];
}

+ (id)alertViewWithTitle:(NSString *)title message:(NSString *)message {
	return [[[self class] alloc] initWithTitle:title message:message];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
	return [self initWithTitle:title message:message delegate:self.delegater cancelButtonTitle:nil otherButtonTitles:nil];
}

- (SCAlertViewDelegater*)delegater {
    SCAlertViewDelegater* aDelegater = [self associatedValueForKey:&kAlertViewDelegaterKey];
    if (!aDelegater) {
        aDelegater = [[SCAlertViewDelegater alloc] init];
        [self associateValue:aDelegater withKey:&kAlertViewDelegaterKey];
    }
    return aDelegater;
}

#pragma Actions

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(BKBlock)block {
	NSAssert(title.length, @"A button without a title cannot be added to the alert view.");
	NSInteger index = [self addButtonWithTitle:title];
	[self setHandler:block forButtonAtIndex:index];
	return index;
}

- (NSInteger)setCancelButtonWithTitle:(NSString *)title handler:(BKBlock)block {
	if (!title.length)
		title = NSLocalizedString(@"Cancel", nil);
	NSInteger cancelButtonIndex = [self addButtonWithTitle:title];
	self.cancelButtonIndex = cancelButtonIndex;
	[self setHandler:block forButtonAtIndex:cancelButtonIndex];
	return cancelButtonIndex;
}

#pragma mark Properties

- (void)setHandler:(BKBlock)block forButtonAtIndex:(NSInteger)index {
	id key = @(index);
	
	if (block)
		[self.delegater handlers][key] = [block copy];
	else
		[[self.delegater handlers] removeObjectForKey: key];
}

- (BKBlock)handlerForButtonAtIndex:(NSInteger)index {
	id key = @(index);
	return [self.delegater handlers][key];
}

- (BKBlock)cancelBlock {
	return [self handlerForButtonAtIndex:self.cancelButtonIndex];
}

- (void)setCancelBlock:(BKBlock)block {
	if (block && self.cancelButtonIndex == -1) {
		[self setCancelButtonWithTitle:nil handler:block];
		return;
	}
	
	[self setHandler:block forButtonAtIndex:self.cancelButtonIndex];
}

@end
