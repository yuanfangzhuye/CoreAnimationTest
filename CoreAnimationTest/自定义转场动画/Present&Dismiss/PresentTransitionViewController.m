//
//  PresentTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "PresentTransitionViewController.h"
#import "LCPresentTransition.h"

@interface PresentTransitionViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LCPresentTransition *transitionAnimation;

@end

@implementation PresentTransitionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation.transitionType = LCPresentTransitionTypePresent;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, 100, 100, 30)];
    [btn setTitle:@"dismiss" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.transitionImageView];
}

- (void)btnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --- UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return self.transitionAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionAnimation.transitionType = LCPresentTransitionTypeDissmiss;
    
    return self.transitionAnimation;
}


#pragma mark --- getter
- (LCPresentTransition *)transitionAnimation {
    if (!_transitionAnimation) {
        _transitionAnimation = [[LCPresentTransition alloc] init];
        self.transitioningDelegate = self;
    }
    
    return _transitionAnimation;
}

- (UIImageView *)transitionImageView{
    
    if (_transitionImageView == nil) {
        _transitionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
        _transitionImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _transitionImageView.image = [UIImage imageNamed:@"icon-girl"];
    }
    return _transitionImageView;
}


@end
