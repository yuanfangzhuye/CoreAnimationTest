//
//  EmitterLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "EmitterLayerViewController.h"

@interface EmitterLayerViewController ()

@property (nonatomic, strong) CAEmitterLayer * colorBallLayer;

@end

@implementation EmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupEmitterLayer];
    [self setupEmitterCell];
}


- (void)setupEmitterLayer {
    
    // 设置CAEmitterLayer
    self.colorBallLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:self.colorBallLayer];
    
    //粒子发射形状的中心点
    self.colorBallLayer.emitterPosition = CGPointMake(self.view.bounds.size.width, 100);
    //发射源的尺寸大小
    self.colorBallLayer.emitterSize = self.view.frame.size;
    //发射模式
    self.colorBallLayer.emitterMode = kCAEmitterLayerPoints;
    //发射源的形状
    self.colorBallLayer.emitterShape = kCAEmitterLayerPoint;
}

- (void)setupEmitterCell {
    
    // 配置CAEmitterCell
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    //粒子名称
    cell.name = @"colorBallCell";
    //粒子产生率,默认为0
    cell.birthRate = 30.0;
    //粒子生命周期
    cell.lifetime = 10.0;
    //粒子速度,默认为0
    cell.velocity = 40.0;
    //粒子速度平均量
    cell.velocityRange = 100.0;
    //x,y,z方向上的加速度分量,三者默认都是0
    cell.yAcceleration = 15.0;
    //指定纬度,纬度角代表了在x-z轴平面坐标系中与x轴之间的夹角，默认0:
    cell.emissionLongitude = M_PI; // 向左
    //发射角度范围,默认0，以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内;
    cell.emissionRange = M_PI_4; // 围绕X轴向左90度
    // 缩放比例, 默认是1
    cell.scale = 0.2;
    // 缩放比例范围,默认是0
    cell.scaleRange = 0.1;
    // 在生命周期内的缩放速度,默认是0
    cell.scaleSpeed = 0.02;
    // 粒子的内容，为CGImageRef的对象
    cell.contents = (id)[UIImage imageNamed:@"circle_white"].CGImage;
    //颜色
    cell.color = [[UIColor colorWithRed:0.5 green:0.0 blue:1.0 alpha:1.0] CGColor];
    // 粒子颜色red,green,blue,alpha能改变的范围,默认0
    cell.redRange = 1.0;
    cell.greenRange = 1.0;
    cell.blueRange = 0.8;
    
    // 粒子颜色red,green,blue,alpha在生命周期内的改变速度,默认都是0
    cell.blueSpeed = 1.0f;
    cell.alphaSpeed = -0.1;
    
    // 添加
    self.colorBallLayer.emitterCells = @[cell];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [self getLocationPointFromTouchView:event];
    [self setBallInPosition:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [self getLocationPointFromTouchView:event];
    [self setBallInPosition:point];
}

- (CGPoint)getLocationPointFromTouchView:(UIEvent *)event {
    UITouch * touch = [[event allTouches] anyObject];
    return [touch locationInView:self.view];
}


- (void)setBallInPosition:(CGPoint)position {
    
    //创建基础动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorBallCell.scale"];
    basicAnimation.fromValue = @0.2;
    basicAnimation.toValue = @0.5;
    basicAnimation.duration = 1.0;
    
    //线性起搏，使动画在其持续时间内均匀地发生
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 用事务包装隐式动画
    [CATransaction begin];
    //设置是否禁止由于该事务组内的属性更改而触发的操作。
    [CATransaction setDisableActions:YES];
    //为colorBallLayer 添加动画
    [self.colorBallLayer addAnimation:basicAnimation forKey:nil];
    //为colorBallLayer 指定位置添加动画效果
    [self.colorBallLayer setValue:[NSValue valueWithCGPoint:position] forKey:@"emitterPosition"];
    //提交动画
    [CATransaction commit];
}


@end
