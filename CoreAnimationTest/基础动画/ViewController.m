//
//  ViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/12.
//

#import "ViewController.h"
#import "RedView.h"
#import <CoreFoundation/CoreFoundation.h>
#import "TransformViewController.h"
#import "Box3DViewController.h"
#import "CubeViewController.h"
#import "TestViewController.h"
#import "ShapeLayerViewController.h"
#import "TextLayerViewController.h"
#import "TransformLayerViewController.h"
#import "GradientLayerViewController.h"
#import "ReplicatorLayerViewController.h"
#import "ThreeLayerViewController.h"
#import "AVPlayerLayerViewController.h"
#import "EmitterLayerViewController.h"
#import "RainLayerViewController.h"
#import "ClickLikeLayerViewController.h"
#import "BezierCarViewController.h"
#import "PigViewController.h"
#import "QQRefreshViewController.h"
#import "BallCollisionViewController.h"
#import "TransitionViewController.h"
#import "CustomTransitionViewController.h"
#import "DouyinLikeViewController.h"
#import "AddDigitalViewController.h"
#import "MusicAnimationViewController.h"


/*
 动画添加步骤:
 1.找演员CALayer,确定动画主角
 2.写剧本CAAnimation,规定动画怎么样变换
 3.开拍AddAnimation,开始执行
 */

@interface ViewController ()

@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) CALayer *greenLayer;

@property (nonatomic, strong) UIView *fixedCircleView; // 固定
@property (nonatomic, strong) UIView *dragCircleView; // 拖拽

@end

@implementation ViewController

- (void)btnClick {
    MusicAnimationViewController *vc = [[MusicAnimationViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupUI];
    
}

- (void)setupUI {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 88, 30, 30)];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    self.redView = [[RedView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    self.redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.redView];
//
//    self.greenLayer = [CALayer layer];
//    self.greenLayer.frame = CGRectMake(100, 300, 100, 100);
//    self.greenLayer.backgroundColor = [UIColor greenColor].CGColor;
//    [self.view.layer addSublayer:self.greenLayer];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    CALayer *layer = [self.view.layer hitTest:point];
//    if (layer == self.redView.layer) {
//        NSLog(@"red");
//    }
//    else if (layer  == self.greenLayer) {
//        NSLog(@"green");
//    }
//    else {
//        NSLog(@"既不在red，也不在green");
//    }
//
//
////    CABasicAnimation *animation = [CABasicAnimation animation];
////    animation.keyPath = @"position.y";
////    animation.toValue = @400;
////    animation.duration = 1;
////
////    //解决动画恢复到初始位置
////    animation.removedOnCompletion = NO;
////    animation.fillMode = kCAFillModeForwards;
////
////    [self.redView.layer addAnimation:animation forKey:nil];
////
////    [CATransaction begin];
////    [CATransaction setAnimationDuration:1.0];
////    [CATransaction setCompletionBlock:^{
////        CGAffineTransform transform = self.greenLayer.affineTransform;
////        transform = CGAffineTransformRotate(transform, M_PI);
////        self.greenLayer.affineTransform = transform;
////    }];
////    self.greenLayer.backgroundColor = [UIColor yellowColor].CGColor;
////    [CATransaction commit];
//}
//

@end

