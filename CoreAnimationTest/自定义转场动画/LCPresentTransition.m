//
//  LCPresentTransition.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "LCPresentTransition.h"

@interface LCPresentTransition ()

@property (nonatomic, assign) LCPresentTransitionType type;

@end

@implementation LCPresentTransition


+ (instancetype)interactiveTransitionWithTransitionType:(LCPresentTransitionType)type {
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(LCPresentTransitionType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    
    return self;
}


#pragma mark ---- UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_type) {
        case LCPresentTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case LCPresentTransitionTypeDissmiss:
            [self dismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

// present 动画逻辑
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *fromVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}


// dismiss 动画逻辑
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC       = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *toVC   = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
    }];
}


@end
