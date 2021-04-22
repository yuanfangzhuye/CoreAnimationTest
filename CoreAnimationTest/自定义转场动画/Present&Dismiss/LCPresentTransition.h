//
//  LCPresentTransition.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LCPresentTransitionType) {
    LCPresentTransitionTypePresent = 0,
    LCPresentTransitionTypeDissmiss
};

@interface LCPresentTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) LCPresentTransitionType transitionType;

@end
