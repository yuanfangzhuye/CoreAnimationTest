//
//  ShapeLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "ShapeLayerViewController.h"

@interface ShapeLayerViewController ()

@end

@implementation ShapeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(175, 100)];
    
    [bezierPath addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    [bezierPath moveToPoint:CGPointMake(150, 125)];
    [bezierPath addLineToPoint:CGPointMake(150, 175)];
    
    [bezierPath moveToPoint:CGPointMake(100, 150)];
    [bezierPath addLineToPoint:CGPointMake(200, 150)];
    
    [bezierPath moveToPoint:CGPointMake(150, 175)];
    [bezierPath addLineToPoint:CGPointMake(100, 225)];
    
    [bezierPath moveToPoint:CGPointMake(150, 175)];
    [bezierPath addLineToPoint:CGPointMake(200, 225)];
    
    
    CGRect rect = CGRectMake(100, 100, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners1 = UIRectCornerTopLeft | UIRectCornerTopRight;
    UIRectCorner corners2 = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners1 cornerRadii:radii];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor; // 画笔颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor; // 填充颜色
    shapeLayer.lineWidth = 5.0;  // 线宽
    shapeLayer.path = path.CGPath; // shapeLayer 绘制图形路径
    shapeLayer.lineJoin = kCALineJoinRound; // 形状路径连线样式
    shapeLayer.lineCap = kCALineCapRound; // 形状路径线帽样式
    
    [self.view.layer addSublayer:shapeLayer];
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
