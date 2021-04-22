//
//  DoorTransition.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DoorTransitionType) {
    DoorTransitionTypePush,
    DoorTransitionTypePop
};

NS_ASSUME_NONNULL_BEGIN

@interface DoorTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) DoorTransitionType transitionType;

@end

NS_ASSUME_NONNULL_END
