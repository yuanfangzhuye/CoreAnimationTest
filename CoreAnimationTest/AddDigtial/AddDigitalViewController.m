//
//  AddDigitalViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "AddDigitalViewController.h"

@interface AddDigitalViewController ()

@property (nonatomic, strong) UILabel *digitalScaleLabel;
@property (nonatomic, assign) NSUInteger danceCount;

@end

@implementation AddDigitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.danceCount = 0;
    
    self.digitalScaleLabel = [[UILabel alloc] init];
    self.digitalScaleLabel.frame = CGRectMake(0, 200, self.view.bounds.size.width, 200);
    self.digitalScaleLabel.textColor = [UIColor blackColor];
    self.digitalScaleLabel.textAlignment = NSTextAlignmentCenter;
    //这种字体比较粗大 看起来比较好看
    self.digitalScaleLabel.font = [UIFont fontWithName:@"AvenirNext-BoldItalic" size:50];
    [self.view addSubview:self.digitalScaleLabel];
    
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clickButton.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, self.view.bounds.size.height - 100, 200, 40);
    clickButton.backgroundColor = [UIColor redColor];
    [clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clickButton setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:clickButton];
    clickButton.layer.cornerRadius = 5;
    clickButton.clipsToBounds = YES;
    [clickButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)labelAnimationAction:(NSTimeInterval)duration {
    
    //透明度动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.4 * duration;
    opacityAnimation.fromValue = @(0.0);
    opacityAnimation.toValue = @(1.0);
    
    // 缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = duration;
    // 给values属性给了一个数组。这什么意思呢？CABasicAnimation是指定两个状态，而我们的CAKeyframeAnimation则是指定多个状态，动画放大倍数也的确按照我的规划放大缩小了
    scaleAnimation.values = @[@3.0, @1.0, @1.3, @1.0];
    // keyTimes 属性指定的是当前状态节点到初始状态节点的时间占动画总时长的比例。若果不设置keyTimes则匀速播放
    // keyTimes 对应了values的变化.
    scaleAnimation.keyTimes = @[@0.0, @0.16, @0.28, @0.4];
    //是否在播放完成后移除
    scaleAnimation.removedOnCompletion = YES;
    // 播放结束后的状态--保持结束时状态
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    // 动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    // 添加动画(opacityAnimation透明度动画,scaleAnimation缩放动画)
    group.animations = @[opacityAnimation, scaleAnimation];
    // 动画时长
    group.duration = duration;
    // 是否在播放结束后移除
    group.removedOnCompletion = YES;
    // 播放结束后的状态--保持结束时的状态
    group.fillMode = kCAFillModeForwards;
    
    //在字体label图层添加动画组.
    [self.digitalScaleLabel.layer addAnimation:group forKey:nil];
}


- (void)clickButtonAction:(UIButton *)sender {
    
    self.danceCount++;
    [self labelAnimationAction:0.4];
    
    //修改label上的数字
    self.digitalScaleLabel.text = [NSString stringWithFormat:@"+ %tu", self.danceCount];
}


@end
