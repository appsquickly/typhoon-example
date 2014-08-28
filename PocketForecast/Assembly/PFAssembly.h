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
@class PFAppDelegate;
@class PFRootViewController;
@class PFCitiesListViewController;
@class PFWeatherReportViewController;
@class PFAddCityViewController;

/**
* This is the assembly for the PocketForecast application. We'll be bootstrapping Typhoon using the iOS way, by declaring the list of
* assemblies in the application's plist.
*
* For tests, we bootstrap Typhoon in setup.
*/
@interface PFAssembly : TyphoonAssembly

@property(nonatomic, strong, readonly) PFCoreComponents *coreComponents;
@property(nonatomic, strong, readonly) PFThemeProvider *themeProvider;

/**
* Typhoon will hook-in and provide dependency injection on the app delegate, which is available is we use plist-style bootstrapping of
* Typhoon.
*
* Alternatively, we could bootstrap Typhoon manually inside the app delegate, and resolve the initial dependencies from there. The plist
* approach is, however, recommended, especially if using storyboards - otherwise Typhoon won't be hooked in early enough for
* UIStateRestoration to work correctly.
*/
- (PFAppDelegate *)appDelegate;

- (PFRootViewController *)rootViewController;

- (PFCitiesListViewController *)citiesListController;

- (PFWeatherReportViewController *)weatherReportController;

- (PFAddCityViewController *)addCityViewController;

@end