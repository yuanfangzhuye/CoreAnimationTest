//
//  QQRefreshViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/16.
//

#import "QQRefreshViewController.h"

/**
 拆分动画
 1. 两个圆（一个固定圆，一个拖拽圆）
 2. 贝塞尔曲线，求得关键点
 3. 固定圆缩放
 4. 拖拽到一定程度时候需要断开
 5. 回弹效果
 */

@interface QQRefreshViewController ()

@property (nonatomic, strong) UIView *fixedCircleView; // 固定
@property (nonatomic, strong) UIView *dragCircleView; // 拖拽

@property (nonatomic, strong) CAShapeLayer *shapeLayer; // 图层

// 坐标记录
@property (nonatomic, assign) CGPoint oldFrameCenter;
@property (nonatomic, assign) CGRect oldViewFrame;
@property (nonatomic, assign) CGFloat currentDragRadius;

@end

@implementation QQRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}


- (void)setupUI {
    
    // 添加固定圆
    self.fixedCircleView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds) - 50) / 2, CGRectGetHeight(self.view.bounds) - 300, 50, 50)];
    self.fixedCircleView.layer.cornerRadius = 25.0;
    self.fixedCircleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.fixedCircleView];
    
    
    // 添加拖拽圆
    self.dragCircleView = [[UIView alloc] initWithFrame:self.fixedCircleView.frame];
    self.dragCircleView.layer.cornerRadius = 25.0;
    self.dragCircleView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.dragCircleView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.dragCircleView addGestureRecognizer:pan];
    
    // 初始化数据
    self.shapeLayer = [CAShapeLayer layer];
    self.oldFrameCenter = self.dragCircleView.center;
    self.oldViewFrame = self.dragCircleView.frame;
    self.currentDragRadius = CGRectGetWidth(self.dragCircleView.frame) / 2;
}


- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint locationCenter = [pan locationInView:self.view];
        if (locationCenter.x != self.view.bounds.size.width / 2) {
            CGFloat X = self.view.bounds.size.width / 2;
            self.dragCircleView.center = CGPointMake(X, locationCenter.y);
        }
        
        if (self.currentDragRadius < 15) {
            self.dragCircleView.hidden = YES;
            [self.shapeLayer removeFromSuperlayer];
        }
        
        [self caculPoint];
    }
    else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {
        
        [self.shapeLayer removeFromSuperlayer];
        
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            weakSelf.dragCircleView.center = weakSelf.oldFrameCenter;
            
        } completion:^(BOOL finished) {
            
            weakSelf.dragCircleView.hidden = NO;
            weakSelf.dragCircleView.frame = weakSelf.oldViewFrame;
            weakSelf.currentDragRadius = weakSelf.oldViewFrame.size.width / 2;
            weakSelf.dragCircleView.layer.cornerRadius = weakSelf.currentDragRadius;
            
        }];
    }
}


- (void)caculPoint {
    
    // 1. 初始化两个圆的圆心坐标
    CGPoint fixCenter = self.fixedCircleView.center;
    CGPoint dragCenter = self.dragCircleView.center;
    
    //2.计算出斜边长度(根据勾股定理)
    CGFloat distance = fixCenter.y - dragCenter.y;
    
    // 4. 半径
    CGFloat dragRadius = CGRectGetWidth(self.oldViewFrame) / 2 - distance / 10;
    // 更新固定圆的半径
    self.currentDragRadius = dragRadius;
    
    // 计算关键点
    CGPoint pointA = CGPointMake(fixCenter.x - 25.0, fixCenter.y);
    CGPoint pointB = CGPointMake(fixCenter.x + 25.0, fixCenter.y);
    CGPoint pointC = CGPointMake(dragCenter.x + dragRadius, dragCenter.y);
    CGPoint pointD = CGPointMake(dragCenter.x - dragRadius, dragCenter.y);
    CGPoint pointO = CGPointMake((pointA.x + pointD.x) / 2 + distance * 0.1, (pointA.y + pointD.y) / 2);
    CGPoint pointP = CGPointMake((pointB.x + pointC.x) / 2 - distance * 0.1, (pointB.y + pointC.y) / 2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addQuadCurveToPoint:pointD controlPoint:pointO];
    [path addLineToPoint:pointC];
    [path addQuadCurveToPoint:pointB controlPoint:pointP];
    [path closePath];
    
    if (self.dragCircleView.hidden) {
        return;
    }
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer insertSublayer:self.shapeLayer below:self.dragCircleView.layer];
    
    self.dragCircleView.bounds = CGRectMake(0, 0, dragRadius * 2, dragRadius * 2);
    self.dragCircleView.layer.cornerRadius = dragRadius;
}


@end
