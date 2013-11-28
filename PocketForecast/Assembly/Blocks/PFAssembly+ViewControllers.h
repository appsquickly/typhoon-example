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
#import "PFAssembly.h"

@interface PFAssembly (ViewControllers)

- (id)rootViewController;

/**
* Presents the cities list view controller within a navigation controller.
*/
- (id)menuStack;

- (id)citiesListController;

- (id)weatherReportController;

/**
* Presents the add cities controller within a navigation controller.
*/
- (id)addCityStack;

- (id)addCityViewController;

- (id)mainBundle;

@end