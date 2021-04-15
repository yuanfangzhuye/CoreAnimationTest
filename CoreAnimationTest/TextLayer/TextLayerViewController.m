//
//  TextLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "TextLayerViewController.h"
#import "TextLayerLabel.h"

@interface TextLayerViewController ()

@property (nonatomic, strong) TextLayerLabel *customLabel;

@end

@implementation TextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.customLabel = [[TextLayerLabel alloc] init];
    self.customLabel.frame = CGRectMake(20, 400, self.view.frame.size.width - 40, 200);
    [self.view addSubview:self.customLabel];
    
    self.customLabel.textColor = [UIColor greenColor];
    self.customLabel.text = @"我是一个自定义的 TextLayerLabel";
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 200);
    [self.view.layer addSublayer:textLayer];
    
    //字体颜色
    textLayer.foregroundColor = [UIColor redColor].CGColor;
    
    // 对齐方式
    textLayer.alignmentMode = kCAAlignmentCenter;
    
    //环绕在边界范围内
    textLayer.wrapped = YES;
    
    // 字体大小
//    textLayer.fontSize = 12;
    
    // 自定义字体
    UIFont *font = [UIFont systemFontOfSize:15];
    
    // 设置图层字体
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    
    // retina 渲染
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    CFRelease(fontRef);
    
    // 显示的文字信息
    textLayer.string = @"大家好，积累和学习也许是目前最短改变自身现状的唯一捷径";
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
