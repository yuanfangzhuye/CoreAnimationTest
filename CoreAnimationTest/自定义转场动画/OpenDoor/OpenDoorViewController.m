//
//  OpenDoorViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/22.
//

#import "OpenDoorViewController.h"
#import "CloseDoorViewController.h"

@interface OpenDoorViewController ()

@end

@implementation OpenDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.openImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-girl"]];
    self.openImageView.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, 160, 200, 200);
    self.openImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.openImageView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick)];
    [self.openImageView addGestureRecognizer:tapGestureRecognizer];
}


- (void)btnClick {
    CloseDoorViewController *vc = [[CloseDoorViewController alloc] init];
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
