//
//  RedView.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/12.
//

#import "RedView.h"

@interface RedView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation RedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        self.btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 110)];
        self.btn.backgroundColor = [UIColor blueColor];
        [self addSubview:self.btn];
        [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGPoint newPoint = [self convertPoint:point fromView:self.btn];
    
    if ([self.btn pointInside:newPoint withEvent:event]) {
        return self.btn;
    }
    
    return [super hitTest:point withEvent:event];
    
//    if (self.userInteractionEnabled == NO || self.alpha < 0.05 || self.hidden == YES) {
//        return nil;
//    }
//
//    if ([self pointInside:point withEvent:event]) {
//        for (UIView *subView in self.subviews) {
//            CGPoint coverPoint = [subView convertPoint:point fromView:self];
//            UIView * hitTestView = [subView hitTest:coverPoint withEvent:event];
//
//            if (hitTestView) {
//                NSLog(@"%@", hitTestView);
//                return hitTestView;
//            }
//        }
//        NSLog(@"%@", self);
//        return self;
//    }
//
//    NSLog(@"%@", @"nil");
//    return nil;
}

- (void)btnClick {
    NSLog(@"哈哈哈哈");
}

@end
