//
//  TransformLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "TransformLayerViewController.h"

@interface TransformLayerViewController ()

@property (strong, nonatomic) UIView *containerView;

@end

@implementation TransformLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 400)];
    self.containerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.containerView];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D ct1 = CATransform3DIdentity;
    ct1 = CATransform3DTranslate(ct1, 100, 0, 0);
    CALayer *cub1 = [self cubeWithTransform:ct1];
    [self.containerView.layer addSublayer:cub1];
    
    CATransform3D ct2 = CATransform3DIdentity;
    ct2 = CATransform3DTranslate(ct2, -100, 0, 0);
    ct2 = CATransform3DRotate(ct2, M_PI_4, 0, 1, 0);
    ct2 = CATransform3DRotate(ct2, M_PI_4, 1, 0, 0);
    
    CALayer *layer2 = [self cubeWithTransform:ct2];
    [self.containerView.layer addSublayer:layer2];
}


- (CALayer *)faceWithTransform:(CATransform3D)transform {
    
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    // 颜色
    CGFloat red = ((arc4random()) % 255 / 255.0f);
    CGFloat green = ((arc4random()) % 255 / 255.0f);
    CGFloat blue = ((arc4random()) % 255 / 255.0f);
    
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    face.transform = transform;
    
    return face;
}


- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    
    // 创建 cube layer
    CATransformLayer *cube = [CATransformLayer layer];
    
    // face1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // face2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // face5
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // face4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // face3
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // face6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    //center the cube layer within the container(将立方体层至于容器中心)
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2, containerSize.height / 2);
    
    cube.transform = transform;
    
    return cube;
}

@end
