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
#import "PFAssembly.h"
#import "PFThemeProvider.h"
#import "TyphoonComponentFactory.h"

@implementation PFAppDelegate


- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSFontAttributeName            : [UIFont applicationFontOfSize:20],
        NSForegroundColorAttributeName : [UIColor whiteColor],
    }];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    _factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[
        [PFCoreComponents assembly],
        [PFAssembly assembly],
        [PFThemeProvider assembly]
    ]];

    //We can resolve components by having an assembly interface pose in front of the factory. . .
    PFRootViewController* rootViewController = [(PFAssembly*) _factory rootViewController];
    [_window setRootViewController:rootViewController];

    //. . . or we can resolve typhoon-built instances using the TyphoonComponentFactory API
    id <PFCityDao> cityDao = [_factory componentForType:@protocol(PFCityDao)];
    NSString* selectedCity = [cityDao loadSelectedCity];
    if (!selectedCity)
    {
        [rootViewController showCitiesListController];
    }

    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillEnterForeground:(UIApplication*)application
{
    PFRootViewController* rootViewController = [_factory componentForType:[PFRootViewController class]];

    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 7)
    {
        [rootViewController dismissCitiesListController];
    }
}


@end
