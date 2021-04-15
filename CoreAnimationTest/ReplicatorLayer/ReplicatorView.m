//
//  ReplicatorView.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/15.
//

#import "ReplicatorView.h"

@implementation ReplicatorView

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        topImageView.image = [UIImage imageNamed:@"timg-7"];
        [self addSubview:topImageView];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    
    // 间隔
    CGFloat verticalOffset = self.bounds.size.height + 20;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    layer.instanceTransform = transform;
    
    layer.instanceAlphaOffset = -0.7;
}

@end
