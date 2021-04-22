//
//  PushTransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/20.
//

#import "PushTransitionViewController.h"
#import "PopTransitionViewController.h"

@interface PushTransitionViewController ()

@end

@implementation PushTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"push";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 100) / 2, 100, 100, 30)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
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
    PopTransitionViewController *vc = [[PopTransitionViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
