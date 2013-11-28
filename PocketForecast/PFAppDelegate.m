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
#import "Typhoon.h"
#import "PFCoreComponents.h"
#import "UIFont+ApplicationFonts.h"
#import "PFRootViewController.h"
#import "PFViewControllers.h"

@implementation PFAppDelegate

/**
* Switch between the Xml assembly and the block assembly by swapping the lines below.
*/
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSFontAttributeName            : [UIFont applicationFontOfSize:20],
        NSForegroundColorAttributeName : [UIColor whiteColor],
    }];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x9ebeb3)];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*
    * Switch between the Xml and Block assembly style by below.
     */
    TyphoonComponentFactory* factory;

    factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[
        [PFCoreComponents assembly],
        [PFViewControllers assembly]
    ]];
//    factory = ([[TyphoonXmlComponentFactory alloc] initWithConfigFileNames:@"Assembly.xml", @"ViewControllers.xml", nil]);

    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachPostProcessor:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
    [factory makeDefault];

    PFRootViewController* rootViewController = [factory componentForType:[PFRootViewController class]];
    [_window setRootViewController:rootViewController];

    id <PFCityDao> cityDao = [factory componentForType:@protocol(PFCityDao)];
    NSString* selectedCity = [cityDao getCurrentlySelectedCity];
    if (!selectedCity)
    {
        [rootViewController showSideViewController];
    }

    [self.window makeKeyAndVisible];

    return YES;
}

@end
