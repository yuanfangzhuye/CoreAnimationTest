//
//  ViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/12.
//

#import "ViewController.h"
#import "BasicAnimationViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "TransformViewController.h"
#import "Box3DViewController.h"
#import "CubeViewController.h"
#import "ShapeLayerViewController.h"
#import "TextLayerViewController.h"
#import "TransformLayerViewController.h"
#import "GradientLayerViewController.h"
#import "ReplicatorLayerViewController.h"
#import "ThreeLayerViewController.h"
#import "AVPlayerLayerViewController.h"
#import "EmitterLayerViewController.h"
#import "RainLayerViewController.h"
#import "ClickLikeLayerViewController.h"
#import "BezierCarViewController.h"
#import "PigViewController.h"
#import "QQRefreshViewController.h"
#import "BallCollisionViewController.h"
#import "TransitionViewController.h"
#import "CustomTransitionViewController.h"
#import "DouyinLikeViewController.h"
#import "AddDigitalViewController.h"
#import "MusicAnimationViewController.h"
#import "HeaderImageBreatheViewController.h"
#import "PushTransitionViewController.h"
#import "OpenDoorViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = @[
    @[@"基础动画"],
    @[@"仿射变换"],
    @[@"立体盒子效果1", @"立体盒子效果2"],
    @[@"ShapeLayer"],
    @[@"TextLayer"],
    @[@"TransformLayer"],
    @[@"GradientLayer"],
    @[@"ReplicatorLayer"],
    @[@"ThreeLayer"],
    @[@"AVPlayerLayer"],
    @[@"粒子动画", @"模仿下雨", @"点赞"],
    @[@"BezierCarPath"],
    @[@"Pig"],
    @[@"QQRefreshAnimation"],
    @[@"BallCollision"],
    @[@"CATransition"],
    @[@"开门动画（push）", @"push&pop", @"present&dismiss"],
    @[@"抖音点赞"],
    @[@"直播刷礼物数字添加"],
    @[@"音乐专辑旋转"],
    @[@"头像呼吸"]];
    
    [self setupUI];
}


- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionFooterHeight = 0.01;
    [self.view addSubview:self.tableView];
}


#pragma mark --- UITableViewDelegate, UITableViewDataSource
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *str = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)[self.array objectAtIndex:section]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%ld", (long)(section + 1)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        BasicAnimationViewController *vc = [[BasicAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1) {
        TransformViewController *vc = [[TransformViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            Box3DViewController *vc = [[Box3DViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            CubeViewController *vc = [[CubeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 3) {
        ShapeLayerViewController *vc = [[ShapeLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 4) {
        TextLayerViewController *vc = [[TextLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 5) {
        TransformLayerViewController *vc = [[TransformLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 6) {
        GradientLayerViewController *vc = [[GradientLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 7) {
        ReplicatorLayerViewController *vc = [[ReplicatorLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 8) {
        ThreeLayerViewController *vc = [[ThreeLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 9) {
        AVPlayerLayerViewController *vc = [[AVPlayerLayerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 10) {
        if (indexPath.row == 0) {
            EmitterLayerViewController *vc = [[EmitterLayerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            RainLayerViewController *vc = [[RainLayerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2) {
            ClickLikeLayerViewController *vc = [[ClickLikeLayerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 11) {
        BezierCarViewController *vc = [[BezierCarViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 12) {
        PigViewController *vc = [[PigViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 13) {
        QQRefreshViewController *vc = [[QQRefreshViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 14) {
        BallCollisionViewController *vc = [[BallCollisionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 15) {
        TransitionViewController *vc = [[TransitionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 16) {
        if (indexPath.row == 0) {
            OpenDoorViewController *vc = [[OpenDoorViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 1) {
            PushTransitionViewController *vc = [[PushTransitionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 2) {
            CustomTransitionViewController *vc = [[CustomTransitionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 17) {
        DouyinLikeViewController *vc = [[DouyinLikeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 18) {
        AddDigitalViewController *vc = [[AddDigitalViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 19) {
        MusicAnimationViewController *vc = [[MusicAnimationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 20) {
        HeaderImageBreatheViewController *vc = [[HeaderImageBreatheViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

