//
//  MKParallaxManager.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 19/07/13.
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Copyright (c) 2013 Morgan Kennedy
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MKParallaxManager.h"
#import "MKGyroManager.h"

#define zeroPointV 30.0f
#define maxV 60.0f
#define minV 0.0f
#define zeroPointH 0.0f
#define maxH 30.0f
#define minH -30.0f
#define sizePercentPadding 0.0163f

@interface MKParallaxManager()
/**
 Generates the current Frame based on the front facing angle and sideways tilt
 as well as the frame size
 */
- (CGRect)generateCurrentFrameUsingFrontAngle:(CGFloat)frontAngle SideTile:(CGFloat)sideTilt ViewFrame:(CGRect)viewFrame;

@end

@implementation MKParallaxManager

#pragma mark -
#pragma mark - Lifecycle Methods
+ (MKParallaxManager *)standardParallaxManager
{
    MKParallaxManager *standardParallaxManager = [[MKParallaxManager alloc] init];
    return standardParallaxManager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [MKGyroManager sharedGyroManager];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Public Methods
- (CGRect)parallexFrameWithViewFrame:(CGRect)viewFrame
{
    CGFloat roll = [[MKGyroManager sharedGyroManager] roll];
    CGFloat pitch = [[MKGyroManager sharedGyroManager] pitch];
    
    CGFloat frontAngle = zeroPointV;
    CGFloat sideTilt = zeroPointH;
    
    UIViewController *orientationController = [[UIViewController alloc] init];
    
    if (orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        frontAngle = roll * -1;
        sideTilt = pitch;
    }
    else if (orientationController.interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        frontAngle = roll;
        sideTilt = pitch * -1;
    }
    else if (orientationController.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        frontAngle = pitch * -1;
        sideTilt = roll * -1;
    }
    else // Portrait Assumption
    {
        frontAngle = pitch;
        sideTilt = roll;
    }
    
    if (frontAngle < 0)
    {
        frontAngle = frontAngle * -1;
    }
    
    if (frontAngle > maxV)
    {
        frontAngle = maxV;
    }
    else if (frontAngle < minV)
    {
        frontAngle = minV;
    }
    
    if (sideTilt > maxH)
    {
        sideTilt = maxH;
    }
    else if (sideTilt < minH)
    {
        sideTilt = minH;
    }
    
    return [self generateCurrentFrameUsingFrontAngle:frontAngle SideTile:sideTilt ViewFrame:viewFrame];
}

#pragma mark -
#pragma mark - Private Methods
- (CGRect)generateCurrentFrameUsingFrontAngle:(CGFloat)frontAngle SideTile:(CGFloat)sideTilt ViewFrame:(CGRect)viewFrame
{
    CGFloat widthSingleSidePadding = viewFrame.size.width * sizePercentPadding;
    CGFloat heightSingleSidePadding = viewFrame.size.height * sizePercentPadding;
    
    CGFloat newWidth = viewFrame.size.width + (widthSingleSidePadding * 2);
    CGFloat newHeight = viewFrame.size.height + (heightSingleSidePadding * 2);
    
    CGFloat newX = 0 - widthSingleSidePadding;
    CGFloat newY = 0;
    
    if (sideTilt > zeroPointH)
    {
        CGFloat rightTiltPercent = sideTilt / maxH;
        CGFloat shiftFromCenter = rightTiltPercent * widthSingleSidePadding;
        newX = newX - shiftFromCenter;
    }
    else if (sideTilt < zeroPointH)
    {
        CGFloat leftTiltPercent = sideTilt / minH;
        CGFloat shiftFromCenter = leftTiltPercent * widthSingleSidePadding;
        newX = newX + shiftFromCenter;
    }
    
    if (frontAngle > zeroPointV)
    {
        CGFloat topTiltPercent = frontAngle / maxH;
        CGFloat shiftFromCenter = topTiltPercent * heightSingleSidePadding;
        newY = newY - shiftFromCenter;
    }
    else if (frontAngle < zeroPointV)
    {
        CGFloat bottomTiltPercent = frontAngle / minH;
        CGFloat shiftFromCenter = bottomTiltPercent * heightSingleSidePadding;
        newY = newY + shiftFromCenter;
    }
    
    return CGRectMake(newX, newY, newWidth, newHeight);
}

@end
