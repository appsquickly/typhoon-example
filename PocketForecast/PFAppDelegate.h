////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 - 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import <UIKit/UIKit.h>

@class PFCitiesListViewController;
@class PFWeatherReportViewController;
@protocol PFCityDao;

@interface PFAppDelegate : UIResponder<UIApplicationDelegate> {

    id<PFCityDao> _cityDao;
}

@property(nonatomic, strong) UIWindow* window;
@property(nonatomic, strong) UINavigationController* navigationController;
@property(nonatomic, strong) PFWeatherReportViewController* weatherReportController;

@end
