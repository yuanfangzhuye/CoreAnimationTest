//
//  MusicAlbumView.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicAlbumView : UIView

@property (nonatomic, strong) UIImageView *albumImageView;

/**
 开始动画
 @param rate 动画时间系数
 eg： 16 内部🎶音符动画组 动画就是 16 / 4 = duration
 */
- (void)startAnimation:(CGFloat)rate;

/**
 重置视图 删除所有已添加的动画组
 */
- (void)resetView;

@end

NS_ASSUME_NONNULL_END
