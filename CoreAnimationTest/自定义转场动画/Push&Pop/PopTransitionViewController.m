//
//  PopTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "PopTransitionViewController.h"
#import "LCPushTransition.h"

@interface PopTransitionViewController ()

//动画过渡转场
@property (nonatomic, strong) LCPushTransition *transitionAnimation;

@end

@implementation PopTransitionViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation.transitionType = LCPushPopTransitionTypePush;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"pop";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, 100, 100, 30)];
    [btn setTitle:@"pop" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.transitionImageView];
}

- (void)btnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.transitionType = LCPushPopTransitionTypePush;
    }
    else if (operation == UINavigationControllerOperationPop) {
        self.transitionAnimation.transitionType = LCPushPopTransitionTypePop;
    }
    
    return self.transitionAnimation;
}




#pragma mark --- getter
- (LCPushTransition *)transitionAnimation {
    if (!_transitionAnimation) {
        _transitionAnimation = [[LCPushTransition alloc] init];
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

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}

@end
