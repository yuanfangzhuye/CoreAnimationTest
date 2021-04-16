//
//  BezierCarViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/16.
//

#import "BezierCarViewController.h"

@interface BezierCarViewController ()

@end

@implementation BezierCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test];
}

- (void)test {
    // 定义贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置初始线段的起点
    [path moveToPoint:CGPointMake(40, 200)];
    // 设置EndPoint & Control1 Point Control2 Point
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 300)];
    
    // 使用 shapeLayer 可以更高效的渲染图形.并且不使用drawRect方法
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    // 路径
    shapeLayer.path = path.CGPath;
    // 填充颜色
    shapeLayer.fillColor = nil;
    // 线宽
    shapeLayer.lineWidth = 5.0;
    // 路径颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    // 为子图层添加贝塞尔曲线图
    [self.view.layer addSublayer:shapeLayer];
    
    // 添加 🚗 图层
    CALayer *carLayer = [CALayer layer];
    carLayer.frame = CGRectMake(25, 200 - 15, 20, 20);
    carLayer.contents = (id)[UIImage imageNamed:@"car"].CGImage;
    carLayer.anchorPoint = CGPointMake(0.5, 0.8);
    [self.view.layer addSublayer:carLayer];
    
    // 创建关键帧动画
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 路径
    keyframeAnimation.path = path.CGPath;
    keyframeAnimation.duration = 4.0;
    keyframeAnimation.repeatCount = 2;
    keyframeAnimation.rotationMode = kCAAnimationRotateAuto;
    [carLayer addAnimation:keyframeAnimation forKey:nil];
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
