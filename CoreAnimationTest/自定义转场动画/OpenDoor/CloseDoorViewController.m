//
//  CloseDoorViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/22.
//

#import "CloseDoorViewController.h"
#import "DoorTransition.h"

@interface CloseDoorViewController ()

@property (nonatomic, strong) DoorTransition * transitionAnimation;

@end

@implementation CloseDoorViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation.transitionType = DoorTransitionTypePush;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关门";
    
    [self.view addSubview:self.closeImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick)];
    [self.closeImageView addGestureRecognizer:tapGestureRecognizer];
}


- (void)btnClick {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark --- UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.transitionType = DoorTransitionTypePush;
    }
    else if (operation == UINavigationControllerOperationPop) {
        self.transitionAnimation.transitionType = DoorTransitionTypePop;
    }
    
    return self.transitionAnimation;
}


#pragma mark --- getter
- (DoorTransition *)transitionAnimation {
    if (!_transitionAnimation) {
        _transitionAnimation = [[DoorTransition alloc] init];
    }
    
    return _transitionAnimation;
}


- (UIImageView *)closeImageView{
    
    if (_closeImageView == nil) {
        _closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
        _closeImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
        _closeImageView.userInteractionEnabled = YES;
        _closeImageView.image = [UIImage imageNamed:@"icon-girl"];
    }
    return _closeImageView;
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
}


@end
