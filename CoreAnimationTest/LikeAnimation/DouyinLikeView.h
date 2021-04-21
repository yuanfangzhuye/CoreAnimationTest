//
//  DouyinLikeView.h
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DouyinLikeView : UIView

//点赞前图片
@property (nonatomic, strong) UIImageView *beforeLikeImageView;
//点赞后图片
@property (nonatomic, strong) UIImageView *afterLikeImageView;

//点赞时长
@property (nonatomic, assign) CGFloat likeDuration;
//点赞按钮填充颜色
@property (nonatomic, strong) UIColor *likeFillColor;

@end

NS_ASSUME_NONNULL_END
