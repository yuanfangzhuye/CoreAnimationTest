//
//  ThreeLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "ThreeLayerViewController.h"

@interface ThreeLayerViewController ()

@property (nonatomic, strong) CALayer *rootLayer;

@end

@implementation ThreeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.rootLayer = [CALayer layer];
    
    //应用透视投影
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    self.rootLayer.sublayerTransform = transform;
    self.rootLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.rootLayer];
    
    NSArray *colors = @[[UIColor colorWithRed:0.263 green:0.769 blue:0.319 alpha:1.000], [UIColor colorWithRed:0.990 green:0.759 blue:0.145 alpha:1.000], [UIColor colorWithRed:0.084 green:0.398 blue:0.979 alpha:1.000]];
    [self addLayersWithColors:colors];
    
    [self performSelector:@selector(layerAnimation) withObject:nil afterDelay:1.0];
}


- (void)addLayersWithColors:(NSArray *)colors {
    
    for (UIColor *itemcolor in colors) {
        
        // 创建图层
        CALayer *layer = [CALayer layer];
        //颜色
        layer.backgroundColor = itemcolor.CGColor;
        //大小
        layer.bounds = CGRectMake(0, 0, 200, 200);
        //位置
        layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        //透明度
        layer.opacity = 0.8;
        //圆角
        layer.cornerRadius = 10.0;
        
        //边框
        layer.borderColor = [UIColor whiteColor].CGColor;
        layer.borderWidth = 1.0;
        
        //阴影
        layer.shadowColor = [UIColor grayColor].CGColor;
        layer.shadowOffset = CGSizeMake(0, 2);
        layer.shadowOpacity = 0.35;
        
        //光栅化
        layer.shouldRasterize = YES;
        
        [self.rootLayer addSublayer:layer];
    }
}

- (void)layerAnimation {
    
    //创建基本动画以围绕Y轴和Z轴旋转
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(85 * M_PI / 180, 0, 1, 1)];
    basicAnimation.duration = 1.5;
    
    //自动翻转
    basicAnimation.autoreverses = YES;
    
    // 重复次数
    basicAnimation.repeatCount = HUGE_VALF;
    
    // 定义动画步调的计时函数
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CGFloat tx = 0;
    // 循环浏览子图层并附加动画
    for (CALayer *subLayer in [self.rootLayer sublayers]) {
        //为图层添加动画
        [subLayer addAnimation:basicAnimation forKey:nil];
        
        // 创建沿X轴平移的动画
        CABasicAnimation *translateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        translateAnimation.fromValue = [NSValue valueWithCATransform3D:subLayer.transform];
        translateAnimation.toValue = [NSNumber numberWithFloat:tx];
        translateAnimation.duration = 1.5;
        translateAnimation.autoreverses = YES;
        translateAnimation.repeatCount = HUGE_VALF;
        translateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [subLayer addAnimation:translateAnimation forKey:nil];
        
        tx += 35;
    }
}

@end
