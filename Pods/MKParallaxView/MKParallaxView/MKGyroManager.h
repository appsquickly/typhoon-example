//
//  MKGyroManager.h
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

#import <Foundation/Foundation.h>

/**
 This is a singleton instance of the gyroscope manager who's
 main purpose is to consistantly notify the app of the
 x, y, z, roll, pitch, & yaw information
 */
@class MKGyroManager;

@protocol MKGyroManagerDelegate <NSObject>

@optional
/**
 Triggers each time the angles are calculated
 @param roll value as a float
 @param pitch value as a float
 @param yaw value as a float
 */
- (void)MKGyroManagerUpdatedRoll:(CGFloat)roll Pitch:(CGFloat)pitch Yaw:(CGFloat)yaw;

@end

@interface MKGyroManager : NSObject
/**
 The delegate to send the policy
 */
@property (nonatomic, weak) id<MKGyroManagerDelegate> delegate;

/**
 The last recorded Roll Value
 */
@property (nonatomic, assign, readonly) CGFloat roll;

/**
 The last recorded Pitch Value
 */
@property (nonatomic, assign, readonly) CGFloat pitch;

/**
 The last recorded Yaw Value
 */
@property (nonatomic, assign, readonly) CGFloat yaw;

/**
 Initialises the gyro manager as a singleton
 */
+ (MKGyroManager *)sharedGyroManager;

@end

/**
 Gives the same info in userInfo as - (void)MKGyroManagerUpdatedRoll:(CGFloat)roll Pitch:(CGFloat)pitch Yaw:(CGFloat)yaw;
 */
extern NSString *const MKGyroManagerUpdateAnglesNotification;