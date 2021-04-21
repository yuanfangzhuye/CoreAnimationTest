//
//  PresentTransitionViewController.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import <UIKit/UIKit.h>

@protocol LCPresentedOneControllerDelegate <NSObject>

- (void)presentedControllerDissmiss;
//- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end

@interface PresentTransitionViewController : UIViewController <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id<LCPresentedOneControllerDelegate> delegate;

@end
