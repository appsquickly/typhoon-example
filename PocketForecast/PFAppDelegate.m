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
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize weatherReportController = _weatherReportController;




- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    SpringXmlComponentFactory* factory = [[SpringXmlComponentFactory alloc] initWithConfigFileName:@"Assembly.xml"];
    [factory makeDefault];
    _cityDao = [factory componentForKey:@"cityDao"];


    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self makeViewControllers];

    NSString* selectedCity = [_cityDao getCurrentlySelectedCity];
    if (selectedCity) {
        [_weatherReportController setCityName:selectedCity];
        [_window setRootViewController:_weatherReportController];
    }
    else {
        [_window setRootViewController:_navigationController];
    }

    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];

    return YES;


}





/* ================================================== Private Methods =============================================== */
- (void) makeViewControllers {
    PFCitiesListViewController* citiesController =
            [[PFCitiesListViewController alloc] initWithNibName:@"CitiesList" bundle:[NSBundle mainBundle]];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:citiesController];
    [_navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];


    _weatherReportController =
            [[PFWeatherReportViewController alloc] initWithNibName:@"WeatherReport" bundle:[NSBundle mainBundle]];
}


@end
