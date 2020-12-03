////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2015 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////


#import "UIView+NanoFrame.h"

@implementation UIView (NanoFrame)

-(void)setPosition:(CGPoint)position
{
    [self setCenter:CGPointMake(position.x + self.bounds.size.width/2.0f, position.y + self.bounds.size.height/2.0f)];
}

-(CGPoint)position
{
    return self.frame.origin;
}

-(void)setViewSize:(CGSize)size
{
    CGRect r = self.bounds;
    r.size = size;
    self.bounds = r;
}

-(CGSize)viewSize
{
    return self.bounds.size;
}

-(void)setWidth:(float)width
{
    CGRect r = self.bounds;
    r.size.width = width;
    self.bounds = r;
}

-(float)width
{
    return self.bounds.size.width;
}

-(void)setHeight:(float)height
{
    CGRect r = self.bounds;
    r.size.height = height;
    self.bounds = r;
}

-(float)height
{
    return self.bounds.size.height;
}

-(void)setX:(float)value
{
    [self setFrame:CGRectMake(value, self.y, self.bounds.size.width, self.bounds.size.height)];
}

-(float)x
{
    return self.frame.origin.x;
}

-(void)setY:(float)value
{
    [self setFrame:CGRectMake(self.x, value, self.bounds.size.width, self.bounds.size.height)];
}

-(float)y
{
    return self.frame.origin.y;
}

-(void)setRight:(float)value
{
    [self setCenter:CGPointMake(value - self.bounds.size.width / 2.0f, self.center.y)];
}

-(float)right
{
    return CGRectGetMaxX(self.frame);
}

-(void)setBottom:(float)value
{
    [self setCenter:CGPointMake(self.center.x, value - self.bounds.size.height / 2.0f)];
}

-(float)bottom
{
    return CGRectGetMaxY(self.frame);
}

-(void)centerInRect:(CGRect)rect
{
    [self centerHorizontallyInRect:rect];
    [self centerVerticallyInRect:rect];
}

- (void)centerVerticallyInRect:(CGRect)rect
{
    self.y = rect.origin.y + (rect.size.height - self.bounds.size.height)/2.0f;
}

- (void)centerHorizontallyInRect:(CGRect)rect
{
    self.x = rect.origin.x + (rect.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerInSuperView
{
    self.center = CGPointMake(self.superview.bounds.size.width/2.0f, self.superview.bounds.size.height/2.0f);
}

- (void)centerVerticallyInSuperView
{
    self.y = (self.superview.bounds.size.height - self.bounds.size.height)/2.0f;
}

- (void)centerHorizontallyInSuperView
{
    self.x = (self.superview.bounds.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.x = view.x + (view.bounds.size.width - self.bounds.size.width)/2.0f;
}

- (void)centerHorizontallyBelow:(UIView *)view
{
    [self centerHorizontallyBelow:view padding:0.0f];
}

-(void)alignLeftHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.x = view.x;
}

-(void)alignLeftHorizontallyBelow:(UIView *)view
{
    [self alignLeftHorizontallyBelow:view padding:0.0f];
}

-(void)alignRightHorizontallyBelow:(UIView *)view padding:(CGFloat)padding
{
    self.y = CGRectGetMaxY(view.frame) + padding;
    self.right = view.right;
}

-(void)alignRightHorizontallyBelow:(UIView *)view
{
    [self alignRightHorizontallyBelow:view padding:0.0];
}

- (void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii
{
    CALayer *tMaskLayer = [self maskForRoundedCorners:corners withRadii:radii];
    self.layer.mask = tMaskLayer;
}

- (CALayer *)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;

    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:maskLayer.bounds byRoundingCorners:corners
        cornerRadii:radii];
    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.path = [roundedPath CGPath];

    return maskLayer;
}


@end
