//
//  DVParallaxView.m
//  ParallaxViewTest
//
//  Created by Mikhail Grushin on 11.07.13.
//  Copyright (c) 2013 DENIVIP Group. All rights reserved.
//

#import "DVParallaxView.h"
#import <CoreMotion/CoreMotion.h>

#define DV_ROTATION_THRESHOLD 0.1f
#define DV_ROTATION_MULTIPLIER 2.5f

@interface DVParallaxView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

@implementation DVParallaxView

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.parallaxDistanceFactor = 2.f;
        self.parallaxFrontFactor = 20.f;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundImageView];
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
        [self addGestureRecognizer:panRecognizer];
    }
    return self;
}

#pragma mark - Getters

-(CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkHandler)];
    }
    
    return _displayLink;
}

-(CMMotionManager *)motionManager {
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = 0.03f;
    }
    
    return _motionManager;
}

-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.contentMode = UIViewContentModeCenter;
        _backgroundImageView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                  CGRectGetMidY(self.bounds));
    }
    
    return _backgroundImageView;
}

#pragma mark - Setters

-(void)setParallaxDistanceFactor:(float)parallaxDistanceFactor {
    _parallaxDistanceFactor = MAX(0.f, parallaxDistanceFactor);
}

-(void)setParallaxFrontFactor:(float)parallaxFrontFactor {
    _parallaxFrontFactor = MAX(0.f, parallaxFrontFactor);
}


-(void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    [self.backgroundImageView setImage:_backgroundImage];
    
    CGPoint origin = CGPointMake(CGRectGetMidX(self.bounds) - backgroundImage.size.width/2.f,
                                 CGRectGetMidY(self.bounds) - backgroundImage.size.height/2.f);
    
    self.backgroundImageView.frame = (CGRect){.origin = origin, .size = backgroundImage.size};
}

-(void)setFrontView:(UIView *)frontView {
    _frontView = frontView;
    [self addSubview:frontView];
}

-(void)setContentOffset:(CGPoint)contentOffset {
    BOOL backgroundReachedEdgeX = NO;
    BOOL backgroundReachedEdgeY = NO;
    double contentDivider;
    
    if (self.backgroundImageView) {
        contentDivider = self.subviews.count*self.parallaxDistanceFactor;
        CGPoint newCenter = CGPointMake(self.backgroundImageView.center.x + (contentOffset.x - _contentOffset.x)/contentDivider,
                                        self.backgroundImageView.center.y - (contentOffset.y - _contentOffset.y)/contentDivider);
        
        if ((newCenter.x - self.backgroundImageView.frame.size.width/2.f) > 0.f ||
            (newCenter.x + self.backgroundImageView.frame.size.width/2.f) < self.bounds.size.width) {
            newCenter.x = self.backgroundImageView.center.x;
            backgroundReachedEdgeX = YES;
        }
        
        if ((newCenter.y - self.backgroundImageView.frame.size.height/2.f) > 0.f ||
            (newCenter.y + self.backgroundImageView.frame.size.height/2.f) < self.bounds.size.height) {
            newCenter.y = self.backgroundImageView.center.y;
            backgroundReachedEdgeY = YES;
        }
        
        self.backgroundImageView.center = newCenter;
    }
    
    for (int i = 1; i<self.subviews.count; ++i) {
        UIView *view = [self.subviews objectAtIndex:i];
        contentDivider = (view == self.frontView)?-self.parallaxFrontFactor:((self.subviews.count - i)*self.parallaxDistanceFactor);
        CGFloat newCenterX = backgroundReachedEdgeX?view.center.x:(view.center.x + (contentOffset.x - _contentOffset.x)/contentDivider);
        CGFloat newCenterY = backgroundReachedEdgeY?view.center.y:(view.center.y - (contentOffset.y - _contentOffset.y)/contentDivider);
        view.center = CGPointMake(newCenterX, newCenterY);
    }
    
    _contentOffset = contentOffset;
}

-(void)setGyroscopeControl:(BOOL)gyroscopeControl {
    if (_gyroscopeControl == gyroscopeControl)
        return;
    
    _gyroscopeControl = gyroscopeControl;
    
    if (gyroscopeControl) {
        [self.motionManager startDeviceMotionUpdates];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    } else {
        [self.displayLink invalidate];
        [self.motionManager stopDeviceMotionUpdates];
        self.motionManager = nil;
    }
}

#pragma mark - Overriding

-(void)addSubview:(UIView *)view {
    if (self.frontView)
        [super insertSubview:view belowSubview:self.frontView];
    else
        [super addSubview:view];
}

#pragma mark - Gyroscope to offset
         
- (CGPoint)contentOffsetWithRotationRate:(CMRotationRate)rotationRate {
    double xOffset = (fabs(rotationRate.y) > DV_ROTATION_THRESHOLD)?rotationRate.y*DV_ROTATION_MULTIPLIER:0.f;
    double yOffset = (fabs(rotationRate.x) > DV_ROTATION_THRESHOLD)?rotationRate.x*DV_ROTATION_MULTIPLIER:0.f;
    CGPoint newOffset = CGPointMake(self.contentOffset.x + xOffset,
                                    self.contentOffset.y + yOffset);
    return newOffset;
}
                        
- (void)displayLinkHandler {
    [self setContentOffset:[self contentOffsetWithRotationRate:self.motionManager.deviceMotion.rotationRate]];
}

#pragma mark - Gesture handler

- (void)panHandler:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self];
    [self setContentOffset:CGPointMake(self.contentOffset.x + translation.x,
                                       self.contentOffset.y - translation.y)];
    
    [pan setTranslation:CGPointZero inView:self];
}

@end
