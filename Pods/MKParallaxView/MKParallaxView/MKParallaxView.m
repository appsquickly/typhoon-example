//
//  MKParallaxView.m
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

#import "MKParallaxView.h"
#import "MKParallaxManager.h"

#define defaultUpdateRate 60

@interface MKParallaxView()

/**
 The view that everything goes in
 */
@property (nonatomic, strong) UIScrollView *frameScrollView;

/**
 The image view that sits within the frame of the view and shifts with the Gyro
 */
@property (nonatomic, strong) UIImageView *parallaxImageView;

/**
 External manager handeling the logic of the Parallax effect
 */
@property (nonatomic, strong) MKParallaxManager *parallaxManager;

/**
 Timer to update the view
 */
@property (nonatomic, strong) NSTimer *updateTimer;

/**
 Animate Change from current position to new position
 */
- (void)updateParallaxImage;

@end

@implementation MKParallaxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _backgroundShouldRepeat = NO;
        _backgroundImage = nil;
        
        self.backgroundColor = [UIColor clearColor];
        
        _updateRate = defaultUpdateRate;
        
        _parallaxManager = [MKParallaxManager standardParallaxManager];
        
        _frameScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _frameScrollView.scrollEnabled = NO;
        
        _parallaxImageView = [[UIImageView alloc] initWithFrame:[_parallaxManager parallexFrameWithViewFrame:_frameScrollView.frame]];
        _parallaxImageView.backgroundColor = [UIColor clearColor];
        _parallaxImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _updateTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f / self.updateRate)
                                                        target:self
                                                      selector:@selector(updateParallaxImage)
                                                      userInfo:nil
                                                       repeats:YES];
    }
    
    return self;
}

- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    self.frameScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.frameScrollView];
    
    [self updateParallaxImage];
    [self.frameScrollView addSubview:self.parallaxImageView];
}

#pragma mark -
#pragma mark - Overriding Methods
- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.parallaxImageView.backgroundColor = backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.parallaxImageView.image = backgroundImage;
}

- (void)setUpdateRate:(NSInteger)updateRate
{
    _updateRate = updateRate;
    
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0f / self.updateRate)
                                                        target:self
                                                      selector:@selector(updateParallaxImage)
                                                      userInfo:nil
                                                       repeats:YES];
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    self.parallaxImageView.contentMode = contentMode;
}

#pragma mark -
#pragma mark - Private Methods
- (void)updateParallaxImage
{
    CGRect toFrame = [self.parallaxManager parallexFrameWithViewFrame:self.frame];
    
    [UIView animateWithDuration:(1.0f / self.updateRate) animations:^{
        self.parallaxImageView.frame = toFrame;
    }];
}

@end
