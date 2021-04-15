//
//  TextLayerLabel.m
//  CoreAnimationTest
//
//  Created by lab team on 2021/4/14.
//

#import "TextLayerLabel.h"

@implementation TextLayerLabel

+ (Class)layerClass {
    return  [CATextLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (CATextLayer *)textLayer {
    return (CATextLayer *)self.layer;
}

- (void)setupUI {
    self.text = self.text;
    self.textColor = self.textColor;
    self.font = self.font;
    
    [self textLayer].alignmentMode = kCAAlignmentCenter;
    [self textLayer].wrapped = YES;
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self textLayer].string = text;
}

- (void)setFont:(UIFont *)font {
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)setTextColor:(UIColor *)textColor {
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

@end
