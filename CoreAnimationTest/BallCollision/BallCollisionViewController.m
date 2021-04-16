//
//  BallCollisionViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/16.
//

#import "BallCollisionViewController.h"

@interface BallCollisionViewController ()

@property (nonatomic, strong) UIImageView *redImageView;
@property (nonatomic, strong) UIImageView *greenImageView;
@property (nonatomic, strong) UIImageView *yellowImageView;

@property (nonatomic, strong) UIDynamicAnimator *animator1;
@property (nonatomic, strong) UIDynamicAnimator *animator2;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;
@property (nonatomic, strong) UISnapBehavior *snapBehavior;

@end

@implementation BallCollisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //红色View
    _redImageView = [[UIImageView alloc]initWithFrame:CGRectMake(88, 200, 50, 50)];
    _redImageView.image = [UIImage imageNamed:@"ball.png"];
    _redImageView.userInteractionEnabled = YES;
    _redImageView.backgroundColor =[UIColor redColor];
    _redImageView.layer.masksToBounds = YES;
    _redImageView.layer.cornerRadius = 25;
    [self.view addSubview:_redImageView];
    
    //绿色View
    _greenImageView = [[UIImageView alloc]initWithFrame:CGRectMake(226, 200, 50, 50)];
    _greenImageView.backgroundColor = [UIColor greenColor];
    _greenImageView.image = [UIImage imageNamed:@"ball2.png"];
    _greenImageView.userInteractionEnabled = YES;
    _greenImageView.layer.masksToBounds = YES;
    _greenImageView.layer.cornerRadius = 25;
    [self.view addSubview:_greenImageView];
    
    //黄色View
    _yellowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(314, 200, 50, 50)];
    _yellowImageView.backgroundColor = [UIColor yellowColor];
    _yellowImageView.image = [UIImage imageNamed:@"ball3.png"];
    _yellowImageView.userInteractionEnabled = YES;
    _yellowImageView.layer.masksToBounds = YES;
    _yellowImageView.layer.cornerRadius = 25;
    [self.view addSubview:_yellowImageView];
    
    _animator1 = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _animator2 = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 创建自由落体行为 - 重力
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[_redImageView, _greenImageView, _yellowImageView]];
    gravityBehavior.magnitude = 2;
    [_animator1 addBehavior:gravityBehavior];

    // 碰撞行为
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[_redImageView, _greenImageView, _yellowImageView]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;


    // 利用贝塞尔曲线设置边界
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 150, self.view.bounds.size.width, self.view.bounds.size.width)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;

    // 画笔颜色
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5;

    [self.view.layer addSublayer:shapeLayer];

    [collisionBehavior addBoundaryWithIdentifier:@"circle" forPath:path];
    [_animator1 addBehavior:collisionBehavior];


//    // 捕捉行为
    CGPoint point = CGPointMake(10, 400);
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:_greenImageView snapToPoint:point];
    self.snapBehavior.damping = 1;
    [_animator1 addBehavior:self.snapBehavior];
//
//
//    // 其他行为拓展
//    UIDynamicItemBehavior *dynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[_redImageView]];
//    dynamicBehavior.elasticity = 0.6;
//    [_animator1 addBehavior:dynamicBehavior];
//
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    [_redImageView addGestureRecognizer:tap];
}


- (void)panAction:(UIGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateBegan) {
        
        UIOffset offset = UIOffsetMake(-10, -10);
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_redImageView offsetFromCenter:offset attachedToAnchor:[tap locationInView:self.view]];
        [_animator1 addBehavior:_attachmentBehavior];
    }
    else if (tap.state == UIGestureRecognizerStateChanged) {
        [_attachmentBehavior setAnchorPoint:[tap locationInView:self.view]];
    }
    else if (tap.state == UIGestureRecognizerStateEnded || tap.state == UIGestureRecognizerStateFailed || tap.state == UIGestureRecognizerStateCancelled) {
        [_animator1 removeBehavior:_attachmentBehavior];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];

    self.snapBehavior.snapPoint = point;
//    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:_yellowImageView snapToPoint:point];
//    snapBehavior.damping = 1;
//
//    [_animator2 removeAllBehaviors];
//    [_animator2 addBehavior:snapBehavior];
}


@end
