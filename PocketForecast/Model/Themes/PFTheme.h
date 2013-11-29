////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>


@interface PFTheme : NSObject

@property (nonatomic, strong, readonly) UIImage* backgroundImage;
@property (nonatomic, strong, readonly) UIColor* navigationBarColor;
@property (nonatomic, strong, readonly) UIColor* forecastTintColor;
@property (nonatomic, strong, readonly) UIColor* controlTintColor;

@end