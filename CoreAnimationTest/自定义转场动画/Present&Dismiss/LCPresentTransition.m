//
//  LCPresentTransition.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "LCPresentTransition.h"
#import "CustomTransitionViewController.h"
#import "PresentTransitionViewController.h"

@implementation LCPresentTransition


#pragma mark ---- UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_transitionType) {
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
    PresentTransitionViewController *toVC = (PresentTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CustomTransitionViewController *fromVC;
    if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        fromVC = nav.viewControllers.lastObject;
    }
    else if ([[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey] isKindOfClass:[CustomTransitionViewController class]]) {
        fromVC = (CustomTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    }
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *tempView = [fromVC.imageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.imageView convertRect:fromVC.imageView.bounds toView:containerView];
    
    fromVC.imageView.hidden = YES;
    toVC.view.alpha = 0;
    toVC.transitionImageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        tempView.frame = [toVC.transitionImageView convertRect:toVC.transitionImageView.bounds toView:containerView];
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        toVC.transitionImageView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}


// dismiss 动画逻辑
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    PresentTransitionViewController *fromVC = (PresentTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CustomTransitionViewController *toVC;
    
    if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        toVC = nav.viewControllers.lastObject;
    }
    else if ([[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] isKindOfClass:[CustomTransitionViewController class]]) {
        toVC = (CustomTransitionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    }
    
    UIView *containerView = [transitionContext containerView];
    UIView *tempView = [fromVC.transitionImageView snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.transitionImageView convertRect:fromVC.transitionImageView.bounds toView:containerView];
    
    fromVC.transitionImageView.hidden = YES;
    [containerView addSubview:tempView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        tempView.frame = [toVC.imageView convertRect:toVC.imageView.bounds toView:containerView];
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        if ([transitionContext transitionWasCancelled]) {
            //手势取消了，原来隐藏的imageView要显示出来
            //失败了隐藏tempView，显示fromVC.imageView
            [tempView removeFromSuperview];
            fromVC.transitionImageView.hidden = NO;
        }else{
            //手势成功，cell的imageView也要显示出来
            //成功了移除tempView，下一次pop的时候又要创建，然后显示cell的imageView
            toVC.imageView.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
}


@end
