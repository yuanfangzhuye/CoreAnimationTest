//
//  RainLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "RainLayerViewController.h"

@interface RainLayerViewController ()

@property (nonatomic, strong) CAEmitterLayer *rainLayer;
@property (nonatomic, strong) UIImageView *rainImageView;

@end

@implementation RainLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setupEmitter];
}


- (void)setupUI {
    
    // 背景图片
    self.rainImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.rainImageView.image = [UIImage imageNamed:@"rain"];
    [self.view addSubview:self.rainImageView];
    
    // 下雨按钮
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:startBtn];
    startBtn.frame = CGRectMake(20, self.view.bounds.size.height - 60, 80, 40);
    startBtn.backgroundColor = [UIColor whiteColor];
    [startBtn setTitle:@"雨停了" forState:UIControlStateNormal];
    [startBtn setTitle:@"下雨" forState:UIControlStateSelected];
    [startBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 雨量按钮
    UIButton * rainBIgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainBIgBtn];
    rainBIgBtn.tag = 100;
    rainBIgBtn.frame = CGRectMake(140, self.view.bounds.size.height - 60, 80, 40);
    rainBIgBtn.backgroundColor = [UIColor whiteColor];
    [rainBIgBtn setTitle:@"下大点" forState:UIControlStateNormal];
    [rainBIgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainBIgBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rainSmallBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rainSmallBtn];
    rainSmallBtn.tag = 200;
    rainSmallBtn.frame = CGRectMake(240, self.view.bounds.size.height - 60, 80, 40);
    rainSmallBtn.backgroundColor = [UIColor whiteColor];
    [rainSmallBtn setTitle:@"太大了" forState:UIControlStateNormal];
    [rainSmallBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [rainSmallBtn addTarget:self action:@selector(rainButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)buttonClick:(UIButton *)sender {
    if (!sender.selected) {
        [self.rainLayer setValue:@0.0 forKeyPath:@"birthRate"];
    }
    else {
        [self.rainLayer setValue:@1.0 forKeyPath:@"birthRate"];
    }
    sender.selected = !sender.selected;
}


- (void)rainButtonClick:(UIButton *)sender {
    NSInteger rate = 1;
    CGFloat scale = 0.05;
    
    if (sender.tag == 100) {
        if (self.rainLayer.birthRate < 30) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate + rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale + scale) forKeyPath:@"scale"];
        }
    }
    else if (sender.tag == 200) {
        if (self.rainLayer.birthRate > 1) {
            [self.rainLayer setValue:@(self.rainLayer.birthRate - rate) forKeyPath:@"birthRate"];
            [self.rainLayer setValue:@(self.rainLayer.scale - scale) forKeyPath:@"scale"];
        }
    }
}


- (void)setupEmitter {
    
    // 设置CAEmitterLayer
    self.rainLayer = [CAEmitterLayer layer];
    // 在背景图上添加粒子图层
    [self.rainImageView.layer addSublayer:self.rainLayer];
    // 发射源位置
    self.rainLayer.emitterPosition = CGPointMake(self.view.bounds.size.width / 2, -30.0);
    // 发射源大小
    self.rainLayer.emitterSize = self.view.frame.size;
    // 发射形状--线性
    self.rainLayer.emitterShape = kCAEmitterLayerLine;
    // 发射模式
    self.rainLayer.emitterMode = kCAEmitterLayerSurface;
    
    
    // 配置cell
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    // 粒子内容
    cell.contents = (id)[[UIImage imageNamed:@"rain_white"] CGImage];
    // 每秒产生的粒子数量的系数
    cell.birthRate = 25.0;
    // 粒子的生命周期
    cell.lifetime = 20.0;
    // 粒子速度.图层的速率。用于将父时间缩放为本地时间，例如，如果速率是2，则本地时间的进度是父时间的两倍。默认值为1。
    cell.speed = 10.0;
    // 粒子速度系数, 默认 1.0
    cell.velocity = 10.0;
    // 每个发射物体的初始平均范围,默认等于0
    cell.velocityRange = 10.0;
    // 粒子在y方向的加速的
    cell.yAcceleration = 1000.0;
    // 粒子缩放比例
    cell.scale = 0.1;
    // 粒子缩放比例范围
    cell.scaleRange = 0;
    
    // 添加到图层上
    self.rainLayer.emitterCells = @[cell];
}


@end
