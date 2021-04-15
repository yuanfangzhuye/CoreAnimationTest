//
//  ClickLikeLayerViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "ClickLikeLayerViewController.h"
#import "CustomLikeButton.h"

@interface ClickLikeLayerViewController ()

@end

@implementation ClickLikeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加点赞按钮
    CustomLikeButton * btn = [CustomLikeButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.bounds.size.width - 30) / 2, (self.view.bounds.size.height - 130) / 2, 30, 130);
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"liek_orange"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)button{
    
    // 点赞
    if (!button.selected) {
        button.selected = !button.selected;
        NSLog(@"点赞");
    }
    // 取消点赞
    else{
        button.selected = !button.selected;
        NSLog(@"取消赞");
    }
}

@end
