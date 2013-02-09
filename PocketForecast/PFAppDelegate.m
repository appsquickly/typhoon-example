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
#import "PFCityDao.h"
#import "PFWeatherReportViewController.h"
#import "Typhoon.h"
#import "TyphoonBlockComponentFactory.h"
#import "PFAssembly.h"

@implementation PFAppDelegate

/**
* Switch between the Xml assembly and the block assembly by swapping the lines below.
*/
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*
    * Switch between the Xml and Block assembly style by below.
     */
    TyphoonComponentFactory* factory;
    factory = ([[TyphoonBlockComponentFactory alloc] initWithAssembly:[PFAssembly assembly]]);
//    factory = ([[TyphoonXmlComponentFactory alloc] initWithConfigFileNames:@"Assembly.xml", @"ViewControllers.xml", nil]);

    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachMutator:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
    [factory makeDefault];

    id <PFCityDao> cityDao = [factory componentForType:@protocol(PFCityDao)];
    NSString* selectedCity = [cityDao getCurrentlySelectedCity];
    if (selectedCity)
    {
        [_window setRootViewController:[factory componentForType:[PFWeatherReportViewController class]]];
    }
    else
    {
        [_window setRootViewController:[factory componentForType:[UINavigationController class]]];
    }

    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];

    return YES;
}

@end
