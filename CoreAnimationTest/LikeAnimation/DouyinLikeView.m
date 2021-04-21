//
//  DouyinLikeView.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "DouyinLikeView.h"

#define FavoriteViewLikeBeforeTag 1 // 点赞
#define FavoriteViewLikeAfterTag  2 // 取消点赞

@implementation DouyinLikeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.beforeLikeImageView = [[UIImageView alloc] initWithFrame:frame];
        self.beforeLikeImageView.contentMode = UIViewContentModeCenter;
        self.beforeLikeImageView.image = [UIImage imageNamed:@"icon_home_like_before"];
        self.beforeLikeImageView.userInteractionEnabled = YES;
        self.beforeLikeImageView.tag = FavoriteViewLikeBeforeTag;
        [self.beforeLikeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:self.beforeLikeImageView];
        
        self.afterLikeImageView = [[UIImageView alloc] initWithFrame:frame];
        self.afterLikeImageView.contentMode = UIViewContentModeCenter;
        self.afterLikeImageView.image = [UIImage imageNamed:@"icon_home_like_after"];
        self.afterLikeImageView.userInteractionEnabled = YES;
        self.afterLikeImageView.tag = FavoriteViewLikeAfterTag;
        [self.afterLikeImageView setHidden:YES];
        [self.afterLikeImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
        [self addSubview:self.afterLikeImageView];
        
    }
    return self;
}


- (void)handleGesture:(UITapGestureRecognizer *)sender {
    
    switch (sender.view.tag) {
        case FavoriteViewLikeBeforeTag:
            //开始动画(点赞)
            [self startAnimation:YES];
            break;
        case FavoriteViewLikeAfterTag:
            //开始动画(取消点赞)
            [self startAnimation:NO];
            break;
        default:
            break;
    }
}


- (void)startAnimation:(BOOL)isLike {
    
    self.beforeLikeImageView.userInteractionEnabled = NO;
    self.afterLikeImageView.userInteractionEnabled = NO;
    
    if (isLike) {
        
        // 三角形贝塞尔曲线中的length
        CGFloat length = 30;
        // 动画时长：容错处理
        CGFloat duration = self.likeDuration > 0 ? self.likeDuration : 0.5;
        // 填充颜色
        UIColor *fillColor = self.likeFillColor == nil ? [UIColor redColor] : self.likeFillColor;
        
        // for 循环创建 6 个 30°角的三角形
        for (NSInteger i = 0; i < 6; i++) {
            // 创建shapeLayer
            CAShapeLayer *shaperLayer = [[CAShapeLayer alloc] init];
            //指定 shapeLayer 的位置 ,以 beforeLikeImageView 图片为中心.就是我们看到白色的❤️背景视图(UIImageView)
            shaperLayer.position = self.beforeLikeImageView.center;
            shaperLayer.fillColor = fillColor.CGColor;
            
            // 创建起始路径---倒三角形
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2, -length)];
            [startPath addLineToPoint:CGPointMake(2, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            // 将startPath转化为CGPath,添加到layer上.
            shaperLayer.path = startPath.CGPath;
            
            //注: 当x,y,z值为0时,代表在该轴方向上不进行旋转,当值为-1时,代表在该轴方向上进行逆时针旋转,当值为1时,代表在该轴方向上进行顺时针旋转
            /*
             注: CATransform3DMakeRotation()函数 当x,y,z值为0时,代表在该轴方向上不进行旋转,当值为-1时,代表在该轴方向上进行逆时针旋转,当值为1时,代表在该轴方向上进行顺时针旋转
             因为我们是需要60°创建一个layer所以需要顺时针 M_PI / 3.0f = 60°. 每循环一次则创建第N个角度乘60°.
             */
            shaperLayer.transform = CATransform3DMakeRotation(M_PI / 3 * i, 0, 0, 1);
            [self.layer addSublayer:shaperLayer];
            
            // 创建动画组
            CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
            // 是否在播放完成后移除。这是一个非常重要的属性，有的时候我们希望动画播放完成，但是保留最终的播放效果是，这个属性一定要改为NO，否则无效。
            group.removedOnCompletion = NO;
            
            //动画的节奏
            /*
             所谓节奏是什么什么意思呢？就是动画执行的快慢交替。有如下几个可选项
             kCAMediaTimingFunctionLinear//线性节奏，就是匀速
             kCAMediaTimingFunctionEaseIn//淡入，缓慢加速进入，然后匀速
             kCAMediaTimingFunctionEaseOut//淡出，匀速，然后缓慢减速移除
             kCAMediaTimingFunctionEaseInEaseOut//淡入淡出，结合以上两者
             kCAMediaTimingFunctionDefault//默认效果
             */
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            //是播放结束后的状态
            /*
             它有四个枚举值
             kCAFillModeForwards//保持结束时状态
             kCAFillModeBackwards//保持开始时状态
             kCAFillModeBoth//保持两者，我没懂两者是什么概念，实际使用中与kCAFillModeBackwards相同
             kCAFillModeRemoved//移除
             这个属性使用的时候要设置removedOnCompletion = NO，否则你是看不到效果的
             */
            group.fillMode = kCAFillModeForwards;
            
            // 动画时长
            group.duration = duration;
            
            /*
             CABasicAnimation用来创建基于两个状态的动画，你只需要给出两个状态，一个初始状态一个终止状态，系统自动为你将中间的动画补全
             from就是指定初始状态
             toValue就是终止状态
             by就是状态的增量
             */
            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnimation.fromValue = @(0);
            scaleAnimation.toValue = @(1.0);
            scaleAnimation.duration = duration * 0.2;
            
            // 创建终止路径
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2, -length)];
            [endPath addLineToPoint:CGPointMake(2, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];
            
            /*
             从我们上一个layer的path位置开始向我们结束位置的path过渡,并且注意开始时间
             pathAnim.beginTime是 duration 0.2也就是说 在上一个动画结束的时间点才开始结束过渡,过渡的时长剩余是duration 0.8.这样两个连贯在一起的动画就执行完了,最后把动画加到动画组 天加给layer.
             */
            //结束动画
            CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnimation.fromValue = (id)shaperLayer.path;
            pathAnimation.toValue = (id)endPath.CGPath;
            pathAnimation.beginTime = duration * 0.2;
            pathAnimation.duration = duration * 0.8;
            
            // 给动画组添加2个动画(scaleAnimation,pathAnimation)
            [group setAnimations:@[scaleAnimation, pathAnimation]];
            // 给图层添加动画组
            [shaperLayer addAnimation:group forKey:nil];
        }
        
        // 取消隐藏
        [self.afterLikeImageView setHidden:NO];
        // 透明度设置
        self.afterLikeImageView.alpha = 0.0;
        // 旋转120度，并缩小0.5倍
        self.afterLikeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(- M_PI / 3 * 2), 0.5, 0.5);
        
        // 创建基础动画
        /*
         Duration: 时长
         delay:延时
         Damping:弹簧效果时长
         velocity:速度
         animation:动画内容
         completion:动画结束
         */
        [UIView animateWithDuration:0.4 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.beforeLikeImageView.alpha = 0;
            self.afterLikeImageView.alpha = 1;
            self.afterLikeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1.0, 1.0);
            
        } completion:^(BOOL finished) {
            
            self.beforeLikeImageView.alpha = 1.0;
            self.beforeLikeImageView.userInteractionEnabled = YES;
            self.afterLikeImageView.userInteractionEnabled = YES;
            
        }];
    }
    else {
        // 取消点赞
        self.afterLikeImageView.alpha = 1.0f;
        self.afterLikeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1, 1);
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.afterLikeImageView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), 0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [self.afterLikeImageView setHidden:YES];
            
            self.beforeLikeImageView.userInteractionEnabled = YES;
            self.afterLikeImageView.userInteractionEnabled = YES;
        }];
    }
}


@end
