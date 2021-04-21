//
//  MusicAnimationViewController.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import "MusicAnimationViewController.h"
#import "MusicAlbumView.h"

@interface MusicAnimationViewController ()

@property (nonatomic, strong) MusicAlbumView *musicAlbum;

@end

@implementation MusicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    self.musicAlbum = [[MusicAlbumView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100, self.view.bounds.size.height - 100, 80, 80)];
    [self.musicAlbum.albumImageView setImage:[UIImage imageNamed:@"timg-7"]];
    [self.view addSubview:self.musicAlbum];
    [self.musicAlbum startAnimation:12.0];
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
