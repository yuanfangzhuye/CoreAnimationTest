//
//  AVPlayerLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "AVPlayerLayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerLayerViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation AVPlayerLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.view.tintColor = [UIColor whiteColor];
    
    // 创建 avplayer
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"cyborg" ofType:@"m4v"];
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:moviePath]];
    [self.player play];
    
    //创建和配置AvPlayerlayer
    AVPlayerLayer *playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playLayer.bounds = CGRectMake(0, 0, 300, 200);
    playLayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    playLayer.borderColor = [UIColor whiteColor].CGColor;
    playLayer.borderWidth = 3.0;
    playLayer.shadowOffset = CGSizeMake(0, 3);
    playLayer.shadowOpacity = 0.8;
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/1000.0;
    
    self.view.layer.sublayerTransform = transform;
    [self.view.layer addSublayer:playLayer];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 300) / 2, [UIScreen mainScreen].bounds.size.height / 2 + 120, 300, 20)];
    slider.minimumValue = -1.0;
    slider.maximumValue = 1.0;
    slider.continuous = NO;
    slider.value = 0;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:slider];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    btn.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 300) / 2, [UIScreen mainScreen].bounds.size.height / 2 + 160, 300, 40);
    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)sliderValueChanged:(UISlider *)slider {
    CALayer *layer = [self.view.layer sublayers][0];
    layer.transform = CATransform3DMakeRotation([slider value], 0, 1, 0);
}

- (void)btnClick:(UIButton *)sender {
    CALayer *layer = [self.view.layer sublayers][0];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    basicAnimation.duration = 1.25;
    basicAnimation.toValue = [NSNumber numberWithFloat:360 * M_PI / 180];
    [layer addAnimation:basicAnimation forKey:nil];
}

- (void)dealloc
{
    [self.player pause];
}

@end
