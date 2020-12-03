////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2015 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////


#import "CALayer+Image.h"

@implementation CALayer (Image)

+(CALayer*)layerWithImage:(UIImage*)image
{
    CALayer* l = [[CALayer alloc] init];
    [l setFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    l.contents = (id)image.CGImage;
    return l;
}

@end
