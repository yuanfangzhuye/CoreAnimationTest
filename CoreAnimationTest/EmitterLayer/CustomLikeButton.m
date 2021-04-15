//
//  CustomLikeButton.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "CustomLikeButton.h"

@interface CustomLikeButton()

@property (nonatomic, strong) CAEmitterLayer *explosionLayer;

@end

@implementation CustomLikeButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupExplosion];
    }
    return self;
}


- (void)setupExplosion {
    
    // 创建发射源
    self.explosionLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:self.explosionLayer];
    
    // 发射模型,轮廓模式,从形状的边界上发射粒子
    self.explosionLayer.emitterMode = kCAEmitterLayerOutline;
    // 粒子从圆形形状发射出来
    self.explosionLayer.emitterShape = kCAEmitterLayerCircle;
    // 发射源尺寸大小
    self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 50, self.bounds.size.height + 50);
    // 渲染模式
    self.explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
    
    
    // 创建粒子
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"explosionCell";
    
    // 透明值变化速度
    cell.alphaSpeed = -1.0;
    // 透明值范围
    cell.alphaRange = 0;
    
    // 缩放比例
    cell.scale = 0.08;
    // 缩放比例范围
    cell.scaleRange = 0.02;
    
    // 生命周期
    cell.lifetime = 1.0;
    // 生命周期范围
    cell.lifetimeRange = 0.1;
    
    // 粒子速度
    cell.velocity = 40.0;
    // 粒子速度范围
    cell.velocityRange = 10.0;
    
    cell.contents = (id)[[UIImage imageNamed:@"spark_red"] CGImage];
    
    self.explosionLayer.emitterCells = @[cell];
}


- (void)layoutSubviews {
    self.explosionLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [super layoutSubviews];
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    // 通过关键帧动画实现缩放
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animation];
    // 设置动画路径
    keyframeAnimation.keyPath = @"transform.scale";
    
    if (selected) {
        // 从没有点击到点击状态 会有爆炸的动画效果
        keyframeAnimation.values = @[@1.5,@2.0, @0.8, @1.0];
        keyframeAnimation.duration = 0.5;
        // 计算关键帧方式
        keyframeAnimation.calculationMode = kCAAnimationCubic;
        // 为图层添加动画
        [self.layer addAnimation:keyframeAnimation forKey:nil];
        
        // 让放大动画先执行完毕 再执行爆炸动画
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.25];
    }
    else {
        [self stopAnimation];
    }
}


// 没有高亮状态
- (void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
}


- (void)startAnimation {
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@1000 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    // 开始动画
    self.explosionLayer.beginTime = CACurrentMediaTime();
    // 延迟停止动画
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.25];
}


- (void)stopAnimation {
    // 用KVC设置颗粒个数
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosionCell.birthRate"];
    // 移除动画
    [self.explosionLayer removeAllAnimations];
}

- (void)drawRect:(CGRect)rect {
    
}


@end
