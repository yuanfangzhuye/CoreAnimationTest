//
//  GradientLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "GradientLayerViewController.h"

@interface GradientLayerViewController ()

@end

@implementation GradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(100, 100, 100, 100);
    
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    gradientLayer.locations = @[@0.2, @0.1, @0.7];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    [self.view.layer addSublayer:gradientLayer];
}

@end
