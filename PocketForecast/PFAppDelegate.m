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



#import "PFAppDelegate.h"
#import "PFCityDao.h"
#import "PFWeatherReportViewController.h"
#import "Typhoon.h"
#import "PFAssembly.h"
#import "UIFont+ApplicationFonts.h"

@implementation PFAppDelegate

/**
* Switch between the Xml assembly and the block assembly by swapping the lines below.
*/
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance]
        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont applicationFontOfSize:20], UITextAttributeFont, nil]];


    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*
    * Switch between the Xml and Block assembly style by below.
     */
    TyphoonComponentFactory* factory;
    factory = ([[TyphoonBlockComponentFactory alloc] initWithAssembly:[PFAssembly assembly]]);
//    factory = ([[TyphoonXmlComponentFactory alloc] initWithConfigFileNames:@"Assembly.xml", @"ViewControllers.xml", nil]);

    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachPostProcessor:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
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

    return YES;
}

@end
