//
//  MusicAlbumView.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "MusicAlbumView.h"

@interface MusicAlbumView ()

//专辑背景视图
@property (nonatomic, strong) UIView *albumContainer;
//动画layer,方便 Reset的时候 移除所有layer和动画
@property (nonatomic, strong) NSMutableArray<CALayer *> *noteLayers;

@end

@implementation MusicAlbumView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.初始化layer数组
        self.noteLayers = [[NSMutableArray alloc] init];
        
        // 2.专辑背景容器视图
        self.albumContainer = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.albumContainer];
        
        // 3.添加唱片icon的layer
        CALayer *backgroundLayer = [CALayer layer];
        backgroundLayer.frame = self.bounds;
        backgroundLayer.contents = (__bridge id)[UIImage imageNamed:@"music_cover"].CGImage;
        [self.albumContainer.layer addSublayer:backgroundLayer];
        
        // 4.添加放在唱片上的图片
        self.albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) / 4, CGRectGetHeight(frame) / 4, CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2)];
        self.albumImageView.layer.cornerRadius = CGRectGetWidth(frame) / 2.0 / 2.0;
        self.albumImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.albumImageView.layer.masksToBounds = YES;
        [self.albumContainer addSubview:self.albumImageView];
        
    }
    return self;
}


- (void)startAnimation:(CGFloat)rate {
    
    // 容错处理 防止 rate 输入为负值
    rate = fabs(rate);
    // 首先重置动画
    [self resetView];
    
    [self addNotoAnimation:@"icon_home_musicnote1" delayTime:0.0 rete:rate];
    [self addNotoAnimation:@"icon_home_musicnote2" delayTime:0.0 rete:rate];
    [self addNotoAnimation:@"icon_home_musicnote1" delayTime:0.0 rete:rate];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    rotationAnimation.duration = 6.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.albumContainer.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


- (void)addNotoAnimation:(NSString *)imageName delayTime:(NSTimeInterval)delayTime rete:(CGFloat)rate {
    
    // 创建动画租
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.duration = rate / 4.0;
    animationGroup.beginTime = CACurrentMediaTime() + delayTime;
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 贝塞尔曲线关键点
    CGPoint beginPoint   = CGPointMake(CGRectGetMidX(self.bounds) - 5, CGRectGetMaxY(self.bounds));
    CGPoint endPoint     = CGPointMake(beginPoint.x - 40.0, beginPoint.y - 100.0);
    CGPoint controlPoint = CGPointMake(beginPoint.x - 80.0, beginPoint.y + 10.0);
    
    // bezier 路径帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // 创建贝塞尔轨迹
    UIBezierPath *customPath = [UIBezierPath bezierPath];
    [customPath moveToPoint:beginPoint];
    [customPath addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    pathAnimation.path = customPath.CGPath;
    
    // 旋转帧动画
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    // 这里实际上是控制动画开始弧度和结束弧度 M_PI(180°) 就是半圆 * 0.10 或者 * -0.10j是为了关键点上下偏移的18°的间隙
    [rotationAnimation setValues:@[
        [NSNumber numberWithFloat:0],
        [NSNumber numberWithFloat:M_PI * 0.10],
        [NSNumber numberWithFloat:M_PI * -0.1]]];
    
    // 透明度帧动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [opacityAnimation setValues:@[
        [NSNumber numberWithFloat:0],
        [NSNumber numberWithFloat:0.2],
        [NSNumber numberWithFloat:0.7],
        [NSNumber numberWithFloat:0.2],
        [NSNumber numberWithFloat:0]]];
    
    // 缩放帧动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1.0);
    scaleAnimation.toValue   = @(2.0);
    
    // 添加动画组元素
    [animationGroup setAnimations:@[
        pathAnimation, scaleAnimation, rotationAnimation, opacityAnimation]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.opacity = 0.0;
    shapeLayer.contents = (__bridge id)[UIImage imageNamed:imageName].CGImage;
    shapeLayer.frame = CGRectMake(beginPoint.x, beginPoint.y, 10, 10);
    
    [self.layer addSublayer:shapeLayer];
    [self.noteLayers addObject:shapeLayer];
    
    [shapeLayer addAnimation:animationGroup forKey:nil];
}


- (void)resetView {
    [self.noteLayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperlayer];
    }];
    
    [self.layer removeAllAnimations];
}

@end
