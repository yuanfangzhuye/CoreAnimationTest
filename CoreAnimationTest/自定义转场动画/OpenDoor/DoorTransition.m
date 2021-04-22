//
//  DoorTransition.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/22.
//

#import "DoorTransition.h"
#import "OpenDoorViewController.h"
#import "CloseDoorViewController.h"

@implementation DoorTransition

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.transitionType) {
        case DoorTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case DoorTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *openDoorLeftView  = [fromView snapshotViewAfterScreenUpdates:NO];
    UIView *openDoorRightView = [fromView snapshotViewAfterScreenUpdates:NO];
    
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width / 2, fromView.frame.size.height)];
    leftView.clipsToBounds = YES;
    [leftView addSubview:openDoorLeftView];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(fromView.frame.size.width / 2, 0, fromView.frame.size.width / 2, fromView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [rightView addSubview:openDoorRightView];
    
    [containerView addSubview:toView];
    [containerView addSubview:leftView];
    [containerView addSubview:rightView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
        leftView.frame = CGRectMake(-fromView.frame.size.width / 2, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
        rightView.frame = CGRectMake(fromView.frame.size.width, 0, fromView.frame.size.width / 2, fromView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        fromView.hidden = NO;
        [leftView removeFromSuperview];
        [rightView removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];
    
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(-toView.frame.size.width / 2, 0, toView.frame.size.width / 2, toView.frame.size.height)];
    leftView.clipsToBounds = YES;
    [leftView addSubview:toView];
    
    UIView *rightToView = [toView snapshotViewAfterScreenUpdates:YES];
    rightToView.frame = CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width, toView.frame.size.height);
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(toView.frame.size.width, 0, toView.frame.size.width / 2, toView.frame.size.height)];
    rightView.clipsToBounds = YES;
    [rightView addSubview:rightToView];
    
    [containerView addSubview:fromView];
    [containerView addSubview:leftView];
    [containerView addSubview:rightView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
        leftView.frame = CGRectMake(0, 0, toView.frame.size.width / 2, toView.frame.size.height);
        rightView.frame = CGRectMake(toView.frame.size.width / 2, 0, toView.frame.size.width / 2, toView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        [containerView addSubview:toView];
        [leftView removeFromSuperview];
        [rightView removeFromSuperview];
        toView.hidden = NO;
        
    }];
}


@end
