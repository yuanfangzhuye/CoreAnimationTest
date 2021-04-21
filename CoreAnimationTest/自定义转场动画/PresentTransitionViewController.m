//
//  PresentTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "PresentTransitionViewController.h"
#import "LCPresentTransition.h"

@interface PresentTransitionViewController () 

@end

@implementation PresentTransitionViewController

- (void)dealloc {
    NSLog(@"滚蛋了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 30) / 2, 200, 30, 30)];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick {
    if (_delegate && [_delegate respondsToSelector:@selector(presentedControllerDissmiss)]) {
        [_delegate presentedControllerDissmiss];
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [LCPresentTransition interactiveTransitionWithTransitionType:LCPresentTransitionTypePresent];
}

@end
