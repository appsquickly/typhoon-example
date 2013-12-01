//
//  MKGyroManager.m
//  MKParallaxViewDemo
//
//  Created by Morgan Kennedy on 20/07/13.
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

#import "MKGyroManager.h"
#import <CoreMotion/CoreMotion.h>

#define defaultHertz 1.0f/60.0f
#define defaultGyroUpdateInterval 0.1f

#define degrees(x) ((180 * x) / M_PI)

@interface MKGyroManager()

@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSTimer *timer;

/**
 Calculates the angles in degrees of the device and fires
 the delegate and a notification with the information
 */
- (void)retrieveAngles;

@end

@implementation MKGyroManager

#pragma mark -
#pragma mark - Lifecycle Methods
+ (MKGyroManager *)sharedGyroManager
{
    static MKGyroManager *sharedGyroManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGyroManager = [[MKGyroManager alloc] init];
    });
    return sharedGyroManager;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.deviceMotionUpdateInterval = defaultHertz;
        [_motionManager startDeviceMotionUpdates];
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:defaultHertz
                                                  target:self
                                                selector:@selector(retrieveAngles)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    return self;
}

#pragma mark - 
#pragma mark - Private Methods
- (void)retrieveAngles
{
    CMDeviceMotion *motion = self.motionManager.deviceMotion;
    CMAttitude *attitude = motion.attitude;
    
    _roll = degrees(attitude.roll);
    _pitch = degrees(attitude.pitch);
    _yaw = degrees(attitude.yaw);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MKGyroManagerUpdatedRoll:Pitch:Yaw:)])
    {
        [self.delegate MKGyroManagerUpdatedRoll:self.roll Pitch:self.pitch Yaw:self.yaw];
    }
    
    NSDictionary *userInfo = @{@"roll":[NSNumber numberWithFloat:self.roll],
                               @"pitch":[NSNumber numberWithFloat:self.pitch],
                               @"yaw":[NSNumber numberWithFloat:self.yaw]};
    [[NSNotificationCenter defaultCenter] postNotificationName:MKGyroManagerUpdateAnglesNotification object:self userInfo:userInfo];
}

@end

NSString *const MKGyroManagerUpdateAnglesNotification = @"MKGyroManagerUpdateAnglesNotification";
