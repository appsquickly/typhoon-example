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

    _factory = [self buildComponentFactory];

    PFRootViewController* rootViewController = [_factory componentForType:[PFRootViewController class]];
    [_window setRootViewController:rootViewController];

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


- (TyphoonComponentFactory*)buildComponentFactory
{
    TyphoonComponentFactory* factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[
        [PFCoreComponents assembly],
        [PFAssembly assembly],
        [PFThemeProvider assembly]
    ]];

    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachPostProcessor:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
    return factory;
}

@end
