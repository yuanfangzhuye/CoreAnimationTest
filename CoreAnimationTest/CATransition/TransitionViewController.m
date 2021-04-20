//
//  TransitionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/19.
//

#import "TransitionViewController.h"

/**
 事务性动画
 */

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;

@interface TransitionViewController ()

@property (nonatomic, assign) NSInteger subtype;

@end

@implementation TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.subtype = 0;
    NSArray *titleArray = @[@"淡化效果", @"Push效果", @"揭开效果", @"覆盖效果", @"3D立方体效果", @"吸吮效果", @"翻转效果", @"波纹效果", @"翻页效果", @"反翻页效果", @"开镜头效果", @"光镜头效果", @"下翻页效果", @"上翻页效果", @"左翻转效果", @"右翻转效果"];
    CGFloat itemWidth = (self.view.bounds.size.width  - 15 * 3) / 2;
    CGFloat itemHeight = 60.0;
    
    for (NSInteger i = 0; i < 16; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.tag = i + 1;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%@", [titleArray objectAtIndex:i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(15 + (i % 2) * (itemWidth + 15.0), 100.0 + i / 2 * 75.0, itemWidth, itemHeight);
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addBackgroundImage:@"456"];
}


- (void)btnClick:(UIButton *)sender {
    
    AnimationType animationType = sender.tag;
    
    NSString *subtypeString;
    switch (self.subtype) {
        case 0:
            subtypeString = kCATransitionFromTop;
            break;
        case 1:
            subtypeString = kCATransitionFromLeft;
            break;
        case 2:
            subtypeString = kCATransitionFromBottom;
            break;
        case 3:
            subtypeString = kCATransitionFromRight;
            break;
        default:
            break;
    }
    
    self.subtype++;
    if (self.subtype > 3) {
        self.subtype = 0;
    }
    
    
    switch (animationType) {
        case Fade:
            [self transitionWithType:kCATransitionFade withSubType:subtypeString forView:self.view];
            break;
        case Push:
            [self transitionWithType:kCATransitionPush withSubType:subtypeString forView:self.view];
            break;
        case Reveal:
            [self transitionWithType:kCATransitionReveal withSubType:subtypeString forView:self.view];
            break;
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn withSubType:subtypeString forView:self.view];
            break;
            // 私有API
        case Cube:
            [self transitionWithType:@"cube" withSubType:subtypeString forView:self.view];
            break;
        case SuckEffect:
            [self transitionWithType:@"suckEffect" withSubType:subtypeString forView:self.view];
            break;
        case OglFlip:
            [self transitionWithType:@"oglFlip" withSubType:subtypeString forView:self.view];
            break;
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" withSubType:subtypeString forView:self.view];
            break;
        case PageCurl:
            [self transitionWithType:@"pageCurl" withSubType:subtypeString forView:self.view];
            break;
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" withSubType:subtypeString forView:self.view];
            break;
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" withSubType:subtypeString forView:self.view];
            break;
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" withSubType:subtypeString forView:self.view];
            break;
        case CurlDown:
            [self addAnimationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
        case CurlUp:
            [self addAnimationWithView:self.view withAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
        case FlipFromLeft:
            [self addAnimationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
        case FlipFromRight:
            [self addAnimationWithView:self.view withAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;
        default:
            break;
    }
    
    static NSInteger k = 0;
    if (k == 0) {
        [self addBackgroundImage:@"123.png"];
        k = 1;
    }
    else {
        [self addBackgroundImage:@"456.png"];
        k = 0;
    }
    
}

#pragma mark -- 给view添加动画
- (void)addAnimationWithView:(UIView *)view withAnimationTransition:(UIViewAnimationTransition)transition {
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

#pragma mark -- CATransition 动画实现
- (void)transitionWithType:(NSString *)type withSubType:(NSString *)subType forView:(UIView *)view {
    
    // 创建CATransition对象
    CATransition *animation = [CATransition animation];
    // 设置运动时间
    animation.duration = 1.0;
    // 设置动画类型
    animation.type = type;
    if (subType != nil) {
        animation.subtype = subType;
    }
    
    // 给View添加animation
    [view.layer addAnimation:animation forKey:@"animation"];
}


- (void)addBackgroundImage:(NSString *)imagename {
    UIImage *image = [UIImage imageNamed:imagename];
    
    self.view.layer.contents = (__bridge id)image.CGImage;
    self.view.contentMode = UIViewContentModeScaleAspectFit;
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
}

@end
