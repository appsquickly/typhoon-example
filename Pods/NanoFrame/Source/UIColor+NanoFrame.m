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
#import "UIColor+NanoFrame.h"


@implementation UIColor (NanoFrame)

+ (UIColor *)colorWithHexRGB:(NSUInteger)rgbValue
{
    return [UIColor colorWithRed:(CGFloat)(((rgbValue & 0xFF0000) >> 16) / 255.0)
        green:(CGFloat)(((rgbValue & 0xFF00) >> 8) / 255.0) blue:(CGFloat)((rgbValue & 0xFF) / 255.0) alpha:1.0];
}

+ (UIColor *)colorWithHexRGB:(NSUInteger)rgbValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)(((rgbValue & 0xFF0000) >> 16) / 255.0)
        green:(CGFloat)(((rgbValue & 0xFF00) >> 8) / 255.0) blue:(CGFloat)((rgbValue & 0xFF) / 255.0) alpha:alpha];
}

@end