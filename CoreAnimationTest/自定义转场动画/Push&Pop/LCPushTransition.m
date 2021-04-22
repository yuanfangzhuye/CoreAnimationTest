//
//  LCPushTransition.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "LCPushTransition.h"
#import "PushTransitionViewController.h"
#import "PopTransitionViewController.h"

@implementation LCPushTransition

//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_transitionType) {
        case LCPushPopTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
        case LCPushPopTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    PushTransitionViewController *fromVC;
    PopTransitionViewController *toVC = (PopTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC = nav.viewControllers.lastObject;
    }
    else if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[PushTransitionViewController class]]) {
        fromVC = (PushTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    
    fromVC.imageView.hidden = YES;
    toVC.transitionImageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
        
        tempView.frame = [toVC.transitionImageView convertRect:toVC.transitionImageView.bounds toView:containerView];
        
    }
                     completion:^(BOOL finished) {
        
        toVC.transitionImageView.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    PushTransitionViewController *toVC;
    PopTransitionViewController *fromVC = (PopTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        toVC = nav.viewControllers.lastObject;
    }
    else if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[PushTransitionViewController class]]) {
        toVC = (PushTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [fromVC.transitionImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.transitionImageView convertRect:fromVC.transitionImageView.bounds toView:containerView];
    
    fromVC.transitionImageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    
    UIView * bgView = [[UIView alloc] initWithFrame:fromVC.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:bgView];
    
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        toVC.imageView.hidden = NO;
        [tempView removeFromSuperview];
        [bgView removeFromSuperview];
        
    }];
    
}

@end
