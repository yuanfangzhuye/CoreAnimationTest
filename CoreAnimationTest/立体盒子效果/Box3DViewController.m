//
//  Box3DViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/13.
//

#import "Box3DViewController.h"

@interface Box3DViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation Box3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.redView.layer.transform = transform;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = -1/500.0;
    transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.blueView.layer.transform = transform2;
    
    
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
