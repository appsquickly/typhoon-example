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

@class PFCoreComponents;
@class PFThemeProvider;


@interface PFAssembly : TyphoonAssembly

@property(nonatomic, strong, readonly) PFCoreComponents* coreComponents;
@property(nonatomic, strong, readonly) PFThemeProvider* themeProvider;

- (id)rootViewController;

- (id)citiesListController;

- (id)weatherReportController;

- (id)addCityViewController;

@end