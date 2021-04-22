//
//  LCPushTransition.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LCPushPopTransitionType) {
    LCPushPopTransitionTypePush = 0,
    LCPushPopTransitionTypePop
};

@interface LCPushTransition : NSObject <UIViewControllerAnimatedTransitioning>

//动画转场类型
@property (nonatomic,assign) LCPushPopTransitionType transitionType;

@end
