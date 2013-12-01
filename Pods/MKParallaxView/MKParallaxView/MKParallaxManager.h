//
//  MKParallaxManager.h
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

#import <Foundation/Foundation.h>

/**
 MKParallaxManager is in charge of all calculations relating to the parallax effect
 */
@class MKParallaxManager;

@interface MKParallaxManager : NSObject

/**
 Returns an inited instace of the parallax manager to work with
 @return standardParallaxManager The standard parallax manager
 */
+ (MKParallaxManager *)standardParallaxManager;

/**
 Generates a parallex position (frame) from a view frame (that it sits in), 
 and the current pitch and roll
 @param viewFrame is the Frame of the whole parallax view
 @return the frame that the image should be moving to
 */
- (CGRect)parallexFrameWithViewFrame:(CGRect)viewFrame;

@end
