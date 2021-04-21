//
//  HeaderImageBreatheViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "HeaderImageBreatheViewController.h"

#define CBreathAnimationKey @"BreathAnimationKey"
#define CBreathAnimationName @"BreathAnimationName"
#define CBreathScaleName @"BreathScaleName"

#define HeaderWidth  100.0

@interface HeaderImageBreatheViewController ()

@property (nonatomic, strong) UIView *headerView;

@end

@implementation HeaderImageBreatheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupHeaderView];
    [self addBreathAnimation];
    [self shakeAnimation];
}

- (void)setupHeaderView {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - HeaderWidth) / 2, (self.view.bounds.size.height - HeaderWidth) / 2, HeaderWidth, HeaderWidth)];
    [self.view addSubview:self.headerView];
}


/**
 *  按钮呼吸动画
 */
- (void)addBreathAnimation {
    if (![self.headerView.layer animationForKey:CBreathAnimationKey] && _headerView) {
        
        //呼吸 layer
        CALayer *breathLayer = [CALayer layer];
        breathLayer.position = CGPointMake(HeaderWidth / 2, HeaderWidth / 2); // 位置
        breathLayer.bounds = CGRectMake(0, 0, HeaderWidth / 2, HeaderWidth / 2); // 大小
        breathLayer.backgroundColor = [UIColor clearColor].CGColor; // 背景颜色
        breathLayer.contents = (__bridge id)[UIImage imageNamed:@"timg-7"].CGImage; // 寄宿图
        breathLayer.contentsGravity = kCAGravityResizeAspect; // 填充方式
        [self.headerView.layer addSublayer:breathLayer]; // 将 layer 添加到 headerview
        
        
        // 帧动画（缩放）
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.values = @[@(1.0), @(1.4), @(1.0)]; // 缩放变换
        //定义应用给定关键帧段的时间。数组中的每个值都是一个介于0.0和1.0之间的浮点数字，用于定义应用相应关键帧值的时间点（指定为动画总持续时间的一部分）。数组中的每个连续值必须大于或等于上一个值。通常，数组中的元素数应与Values属性中的元素数或Path属性中的控制点数匹配
        //keyTimes的值为0.0，0.5，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到8秒结束。
        scaleAnimation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        scaleAnimation.duration = 1.0; // 缩放动画时长
        scaleAnimation.repeatCount = FLT_MAX; // 重复次数
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 淡入淡出
        [scaleAnimation setValue:CBreathAnimationKey forKey:CBreathAnimationName]; // 为animation 动画命名
       
        // 添加动画
        [breathLayer addAnimation:scaleAnimation forKey:CBreathAnimationKey];
        
        
        // 放大渐变图层，与 breathLayer 的位置、大小、背景色、寄宿图、填充方式保持一致
        CALayer *bigBreathLayer = [CALayer layer];
        bigBreathLayer.position = breathLayer.position;
        bigBreathLayer.bounds = breathLayer.bounds;
        bigBreathLayer.backgroundColor = [UIColor clearColor].CGColor;
        bigBreathLayer.contents = (__bridge id)[UIImage imageNamed:@"timg-7"].CGImage;
        bigBreathLayer.contentsGravity = kCAGravityResizeAspect;
        // 将 layer 添加到 headerview
        [self.headerView.layer addSublayer:bigBreathLayer];
        
        // 创建 group 动画（缩放+透明）
        CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
        animationGroup.duration = scaleAnimation.duration; // 时长
        animationGroup.repeatCount = FLT_MAX; // 重复次数
        animationGroup.fillMode = kCAFillModeForwards; // 填充方式
        animationGroup.removedOnCompletion = NO; // 动画结束是否移除(NO,默认为Yes)
        
        // 帧动画(缩放)
        CAKeyframeAnimation *bigScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        // 缩放变换
        bigScaleAnimation.values = @[@(1.0), @(3.0)];
        // 定义应用给定关键帧段的时间。数组中的每个值都是一个介于0.0和1.0之间的浮点数字，用于定义应用相应关键帧值的时间点（指定为动画总持续时间的一部分）。数组中的每个连续值必须大于或等于上一个值。通常，数组中的元素数应与Values属性中的元素数或Path属性中的控制点数匹配
        bigScaleAnimation.keyTimes = @[@(0.0), @(1.0)];
        // 缩放时长
        bigScaleAnimation.duration = scaleAnimation.duration;
        // 重复次数
        bigScaleAnimation.repeatCount = FLT_MAX;
        bigScaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]; // (淡入)
        
        // 帧动画（透明）
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        // 透明度变换
        opacityAnimation.values = @[@(1.0), @(0.0)];
        // 动画时长
        opacityAnimation.duration = scaleAnimation.duration;
        //定义应用给定关键帧段的时间。数组中的每个值都是一个介于0.0和1.0之间的浮点数字，用于定义应用相应关键帧值的时间点（指定为动画总持续时间的一部分）。数组中的每个连续值必须大于或等于上一个值。通常，数组中的元素数应与Values属性中的元素数或Path属性中的控制点数匹配
        opacityAnimation.keyTimes = @[@(0.0), @(1.0)];
        // 重复次数
        opacityAnimation.repeatCount = FLT_MAX;
        // (淡入)
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        //动画组数组
        [animationGroup setAnimations:@[bigScaleAnimation, opacityAnimation]];
        

        // 为 bigBreathLayer 添加动画组
        [bigBreathLayer addAnimation:animationGroup forKey:CBreathScaleName];
        
    }
}


- (void)shakeAnimation {
    // 为heartView.layer 添加缩放动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //时长
    animation.duration = 0.35;
    // 缩放变换
    animation.values = @[@(1.0), @(0.8), @(1.0)];
    // 帧时间占比
    animation.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    // 出现方式
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    //为self.heartView.layer添加动画
    [self.headerView.layer addAnimation:animation forKey:nil];
}


@end
