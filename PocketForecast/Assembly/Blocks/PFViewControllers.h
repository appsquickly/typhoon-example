////////////////////////////////////////////////////////////////////////////////
//
//  58 NORTH
//  Copyright 2013 58 North
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of 58 North
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@class PFCoreComponents;


@interface PFViewControllers : TyphoonAssembly

@property(nonatomic, strong, readonly) PFCoreComponents* coreComponents;

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