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

@interface UIView (NanoFrame)

@property CGPoint position;
@property float x;
@property float y;
@property float right;
@property float bottom;
@property CGSize viewSize;
@property float width;
@property float height;

// some of these methods are inspired by Kevin O'Neill's UsefulBits UIView+Positioning methods
// https://github.com/kevinoneill/Useful-Bits/tree/master/UsefulBits/UIKit

- (void)centerInRect:(CGRect)rect;

- (void)centerVerticallyInRect:(CGRect)rect;

- (void)centerHorizontallyInRect:(CGRect)rect;

- (void)centerInSuperView;

- (void)centerVerticallyInSuperView;

- (void)centerHorizontallyInSuperView;

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)centerHorizontallyBelow:(UIView *)view;

- (void)alignLeftHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)alignLeftHorizontallyBelow:(UIView *)view;

- (void)alignRightHorizontallyBelow:(UIView *)view padding:(CGFloat)padding;

- (void)alignRightHorizontallyBelow:(UIView *)view;

- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

- (CALayer *)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;

@end
