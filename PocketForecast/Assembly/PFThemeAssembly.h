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
#import "TyphoonAssembly.h"

@class PFTheme;

/**
* This assembly illustrates the use of several concepts: factory-components, collections, and type-converters.
*/
@interface PFThemeAssembly : TyphoonAssembly

- (PFTheme *)currentTheme;

- (PFTheme *)cloudsOverTheCityTheme;

- (PFTheme *)lightsInTheRainTheme;

- (PFTheme *)beachTheme;

- (PFTheme *)sunsetTheme;

@end