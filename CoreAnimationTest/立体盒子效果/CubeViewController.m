//
//  CubeViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/13.
//

#import "CubeViewController.h"

@interface CubeViewController ()

@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (nonatomic, strong) NSArray *faces;

@end

@implementation CubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.faces = @[self.view1, self.view2, self.view3, self.view4, self.view5, self.view6];
    
    //透视投影，创建单元矩阵
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.containView.layer.sublayerTransform = perspective;
    
    
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addFace:0 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -50);
    [self addFace:1 withTransform:transform];

    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:2 withTransform:transform];
    
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:3 withTransform:transform];

    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:4 withTransform:transform];

    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:5 withTransform:transform];
}


- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform {
    
    // 添加子视图
    UIView *face = self.faces[index];
    [self.containView addSubview:face];
    
    // 把所有子视图放在容器的中心
    CGSize containerSize = self.containView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2, containerSize.height / 2);
    
    // 添加 transform
    face.layer.transform = transform;
}




@end
