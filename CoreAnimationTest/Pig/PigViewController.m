//
//  PigViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/16.
//

#import "PigViewController.h"

@interface PigViewController ()

@property (strong, nonatomic) UIImageView *pigImageView;

@end

@implementation PigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pigImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pig"]];
    self.pigImageView.frame = CGRectMake((self.view.bounds.size.width - 351) / 2, (self.view.bounds.size.height - 310) / 2, 351, 310);
    [self.view addSubview:self.pigImageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.keyPath = @"transform.rotation";
    keyframeAnimation.values = @[@(-(3.0 / 180.0 * M_PI)), @((5.0 / 180.0 * M_PI)), @(-(3.0 / 180.0 * M_PI))];
    keyframeAnimation.autoreverses = YES;
    keyframeAnimation.speed = 2;
    keyframeAnimation.duration = 1;
    keyframeAnimation.repeatCount = MAXFLOAT;
    [self.pigImageView.layer addAnimation:keyframeAnimation forKey:nil];
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
