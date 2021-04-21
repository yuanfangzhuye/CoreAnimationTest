//
//  CustomTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "CustomTransitionViewController.h"
#import "PresentTransitionViewController.h"
#import "LCPresentTransition.h"

@interface CustomTransitionViewController () <LCPresentedOneControllerDelegate>

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 30) / 2, 200, 30, 30)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)btnClick {
    PresentTransitionViewController *vc = [[PresentTransitionViewController alloc] init];
    vc.delegate = self;
    vc.transitioningDelegate = vc;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)presentedControllerDissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
