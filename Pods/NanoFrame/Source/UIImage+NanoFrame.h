////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2015 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (NanoFrame)

+ (UIImage*)imageWithUIView:(UIView*)view;

+ (UIImage*)imageWithCALayer:(CALayer*)layer;

+ (UIImage *)imageNamed:(NSString *)name tint:(UIColor *)tint;

- (UIImage *)tint:(UIColor *)tint;

- (UIColor*)colorAtPixel:(CGPoint)point;

@end
