//
//  MKParallaxView.h
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

#import <UIKit/UIKit.h>

@interface MKParallaxView : UIView

/**
 The image to be set as the background which will shift with the gyro
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 By default it is set to NO (no repeat)
 If YES then the bacground image will automatically repeat (great for a pattern image)
 */
@property (nonatomic, assign) BOOL backgroundShouldRepeat;

/**
 The rate at which the parallax view updates itself 
 (think of it like frames per second)
 Default is 60
 */
@property (nonatomic, assign) NSInteger updateRate;

@end
