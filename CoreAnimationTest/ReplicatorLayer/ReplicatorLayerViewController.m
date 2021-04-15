//
//  RelicatorLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "ReplicatorLayerViewController.h"
#import "ReplicatorView.h"

@interface ReplicatorLayerViewController ()

@end

@implementation ReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    ReplicatorView *view = [[ReplicatorView alloc] initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width - 60, 300)];
    [self.view addSubview:view];
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
