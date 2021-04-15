//
//  TransformViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/12.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.topImageView.image = [UIImage imageNamed:@"timg-7"];
    [self.view addSubview:self.topImageView];
    
    // 投影方式
    /*
     1. 正投影，看不到明显的效果
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.topImageView.layer.transform = transform;
     */
    
    // 2. 透视投影（单个视图仿射变换）
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    perspective = CATransform3DRotate(perspective, M_PI_4, 0, 1, 0);
    self.topImageView.layer.transform = perspective;
    // 正背面渲染--> 渲染技术正背面剔除，判断用户可见/不可见（提高渲染性能）
//    self.topImageView.layer.doubleSided = NO;
    
    
//    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(7.0, 300, 400, 200)];
//    self.containerView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:self.containerView];
//
//    CATransform3D perspective = CATransform3DIdentity;
//    perspective.m34 = -1.0/500.0;
//    // sublayerTransform 子图层上仿射变换（会影响添加在此图层上的子视图）适合多个视图仿射变换
//    self.containerView.layer.sublayerTransform = perspective;
//
//    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
//    self.imageView1.image = [UIImage imageNamed:@"timg-7"];
//    [self.containerView addSubview:self.imageView1];
//
//    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
//    self.imageView1.layer.transform = transform1;
//
//    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 50, 100, 100)];
//    self.imageView2.image = [UIImage imageNamed:@"timg-7"];
//    [self.containerView addSubview:self.imageView2];
//
//    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
//    self.imageView2.layer.transform = transform2;
    
    
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
