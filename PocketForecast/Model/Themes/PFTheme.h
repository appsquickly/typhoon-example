////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2015, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>


@interface PFTheme : NSObject

/**
* Background image name. We could declare this property as a UIImage, however as we're storing a singleton collection of themes we'll use
* NSString to save memory.
*/
@property (nonatomic, strong, readonly) NSString* backgroundResourceName;

@property (nonatomic, strong, readonly) UIColor* navigationBarColor;
@property (nonatomic, strong, readonly) UIColor* forecastTintColor;
@property (nonatomic, strong, readonly) UIColor* controlTintColor;

@end