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


#import "PFApplicationAssembly.h"
#import "PFCoreComponents.h"
#import "PFAddCityViewController.h"
#import "PFRootViewController.h"
#import "PFCitiesListViewController.h"
#import "PFThemeAssembly.h"
#import "PFWeatherReportViewController.h"
#import "PFAppDelegate.h"
#import "TyphoonDefinition+Infrastructure.h"


@implementation PFApplicationAssembly

/* ====================================================================================================================================== */
#pragma mark - Bootstrapping

- (PFAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[PFAppDelegate class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(window) with:[self mainWindow]];
        [definition injectProperty:@selector(cityDao) with:[_coreComponents cityDao]];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

/**
* Set up the main window. We don't really need to use DI for this, but it shows an example of injecting a struct.
*/
- (UIWindow *)mainWindow
{
    return [TyphoonDefinition withClass:[UIWindow class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithFrame:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[NSValue valueWithCGRect:[[UIScreen mainScreen] bounds]]];
        }];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

- (id)config
{
    return [TyphoonDefinition configDefinitionWithName:@"Configuration.plist"];
}

/* ====================================================================================================================================== */

- (PFRootViewController *)rootViewController
{
    return [TyphoonDefinition withClass:[PFRootViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithMainContentViewController:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[self weatherReportController]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}


- (PFCitiesListViewController *)citiesListController
{
    return [TyphoonDefinition withClass:[PFCitiesListViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithCityDao:theme:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[_coreComponents cityDao]];
            [initializer injectParameterWith:[_themeProvider currentTheme]];
        }];
        [definition injectProperty:@selector(assembly)];
    }];
}

- (PFWeatherReportViewController *)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithWeatherClient:weatherReportDao:cityDao:theme:assembly:)
            parameters:^(TyphoonMethod *initializer)
            {
                [initializer injectParameterWith:[_coreComponents weatherClient]];
                [initializer injectParameterWith:[_coreComponents weatherReportDao]];
                [initializer injectParameterWith:[_coreComponents cityDao]];
                [initializer injectParameterWith:[_themeProvider currentTheme]];

                //Inject the TyphoonComponentFactory itself! (It can pose as any of your assembly interfaces).
                [initializer injectParameterWith:self];
            }];
    }];
}

- (PFAddCityViewController *)addCityViewController
{
    return [TyphoonDefinition withClass:[PFAddCityViewController class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:@"AddCity"];
            [initializer injectParameterWith:[NSBundle mainBundle]];
        }];

        [definition injectProperty:@selector(cityDao) with:[_coreComponents cityDao]];
        [definition injectProperty:@selector(weatherClient) with:[_coreComponents weatherClient]];
        [definition injectProperty:@selector(theme) with:[_themeProvider currentTheme]];
        [definition injectProperty:@selector(rootViewController) with:[self rootViewController]];
    }];
}

@end