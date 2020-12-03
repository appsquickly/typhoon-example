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

@interface UIScreen (NanoFrame)

- (CGSize)sizeWithOrientation:(int)orientation;

- (CGRect)rectWithOrientation:(int)orientation;

- (CGSize)currentSize;

- (CGRect)currentRect;

- (CGRect)landscapeRect;

- (CGRect)portraitRect;

- (BOOL)isRetina;

@end
