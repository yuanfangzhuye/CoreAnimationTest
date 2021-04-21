//
//  DouyinLikeViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "DouyinLikeViewController.h"
#import "DouyinLikeView.h"

@interface DouyinLikeViewController ()

@end

@implementation DouyinLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    DouyinLikeView *likeView = [[DouyinLikeView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width)];
    likeView.likeDuration = 0.5;
    likeView.likeFillColor = [UIColor redColor];
    [self.view addSubview:likeView];
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
