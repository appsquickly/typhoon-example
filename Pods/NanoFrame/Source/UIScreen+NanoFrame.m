////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2015 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////

#import "UIScreen+NanoFrame.h"

@implementation UIScreen (NanoFrame)

-(CGSize)sizeWithOrientation:(int)orientation
{
    return [self rectWithOrientation:orientation].size;
}

-(CGRect)rectWithOrientation:(int)orientation
{
    CGRect r = [self applicationFrame];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        return CGRectMake(0, 0, r.size.height, r.size.width);
    }
    else
    {
        return CGRectMake(0, 0, r.size.width, r.size.height);
    }
}

-(CGSize)currentSize
{
    return [self sizeWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

-(CGRect)currentRect
{
    CGSize s = [self currentSize];
    return CGRectMake(0, 0, s.width, s.height);
}

-(CGRect)landscapeRect
{
    return [self rectWithOrientation:UIInterfaceOrientationLandscapeRight];
}

-(CGRect)portraitRect
{
    return [self rectWithOrientation:UIInterfaceOrientationPortrait];
}

-(BOOL)isRetina
{
    return ([self respondsToSelector:@selector(scale)] && [self scale] == 2.0);
}

@end
