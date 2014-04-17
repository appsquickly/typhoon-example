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




#import <UIKit/UIKit.h>

@class PFCitiesListViewController;
@class PFWeatherReportViewController;
@protocol PFCityDao;
@class TyphoonComponentFactory;

@interface PFAppDelegate : UIResponder <UIApplicationDelegate>


@property(nonatomic, strong) UIWindow* window;
@property(nonatomic, strong, readonly) TyphoonComponentFactory* factory;


@end
