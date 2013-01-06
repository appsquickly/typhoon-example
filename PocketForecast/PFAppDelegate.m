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


#import "PFAppDelegate.h"
#import "PFCitiesListViewController.h"
#import "PFCityDao.h"
#import "PFWeatherReportViewController.h"
#import "SpringXmlComponentFactory.h"

@implementation PFAppDelegate


- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SpringComponentFactory
            * factory = [[SpringXmlComponentFactory alloc] initWithConfigFileNames:@"Assembly.xml", @"ViewControllers.xml", nil];
    [factory makeDefault];
    _cityDao = [factory componentForType:@protocol(PFCityDao)];
    _navigationController = [factory componentForType:[UINavigationController class]];
    _navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;

    _weatherReportController = [factory componentForType:[PFWeatherReportViewController class]];

    NSString* selectedCity = [_cityDao getCurrentlySelectedCity];
    if (selectedCity)
    {
        [_weatherReportController setCityName:selectedCity];
        [_window setRootViewController:_weatherReportController];
    }
    else
    {
        [_window setRootViewController:_navigationController];
    }

    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];

    return YES;
}

@end
