//
//  CustomTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "CustomTransitionViewController.h"
#import "PresentTransitionViewController.h"
#import "LCPresentTransition.h"

@interface CustomTransitionViewController ()

@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, 100, 100, 30)];
    [btn setTitle:@"present" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-girl"]];
    self.imageView.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, 160, 200, 200);
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
}


- (void)btnClick {
    PresentTransitionViewController *vc = [[PresentTransitionViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
