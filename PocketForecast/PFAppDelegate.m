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
#import "PFThemeProvider.h"
#import "PFTheme.h"

@implementation PFAppDelegate

/**
* Switch between the Xml assembly and the block assembly by swapping the lines below.
*/
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    /*
    * Switch between the Xml and Block assembly style by below.
     */
    TyphoonComponentFactory* factory;

    factory = [[TyphoonBlockComponentFactory alloc] initWithAssemblies:@[
        [PFCoreComponents assembly],
        [PFViewControllers assembly],
        [PFThemeProvider assembly]
    ]];
//    factory =
//        ([[TyphoonXmlComponentFactory alloc] initWithConfigFileNames:@"CoreComponents.xml", @"ViewControllers.xml", @"Themes.xml", nil]);

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

    [self setGlobalTheme:[factory componentForKey:@"currentTheme"]];

    [self.window makeKeyAndVisible];

    return YES;
}



/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)setGlobalTheme:(PFTheme*)theme
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{
        NSFontAttributeName            : [UIFont applicationFontOfSize:20],
        NSForegroundColorAttributeName : [UIColor whiteColor],
    }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:theme.navigationBarColor];
}

@end
