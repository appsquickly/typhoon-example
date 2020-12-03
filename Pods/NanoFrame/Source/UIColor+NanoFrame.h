////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2015 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////


@interface UIColor (NanoFrame)

/**
* Returns a UIColor from the given hex representation. Example: [UIColor colorWithHexRGB:0x3b789b]
*/
+ (UIColor*)colorWithHexRGB:(NSUInteger)rgb;

+ (UIColor*)colorWithHexRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

@end