//
//  BasicAnimationViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/22.
//

#import "BasicAnimationViewController.h"
#import "RedView.h"

/*
 动画添加步骤:
 1.找演员CALayer,确定动画主角
 2.写剧本CAAnimation,规定动画怎么样变换
 3.开拍AddAnimation,开始执行
 */

@interface BasicAnimationViewController ()

@property (nonatomic, strong) RedView *redView;
@property (nonatomic, strong) CALayer *greenLayer;

@property (nonatomic, strong) UIView *fixedCircleView; // 固定
@property (nonatomic, strong) UIView *dragCircleView; // 拖拽

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.redView = [[RedView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redView];

    self.greenLayer = [CALayer layer];
    self.greenLayer.frame = CGRectMake(100, 300, 100, 100);
    self.greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:self.greenLayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CGPoint point = [[touches anyObject] locationInView:self.view];
    CALayer *layer = [self.view.layer hitTest:point];
    if (layer == self.redView.layer) {
        NSLog(@"red");
    }
    else if (layer  == self.greenLayer) {
        NSLog(@"green");
    }
    else {
        NSLog(@"既不在red，也不在green");
    }


    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.toValue = @400;
    animation.duration = 1;

    //解决动画恢复到初始位置
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    [self.redView.layer addAnimation:animation forKey:nil];

    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.greenLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI);
        self.greenLayer.affineTransform = transform;
    }];
    self.greenLayer.backgroundColor = [UIColor yellowColor].CGColor;
    [CATransaction commit];
}


@end
