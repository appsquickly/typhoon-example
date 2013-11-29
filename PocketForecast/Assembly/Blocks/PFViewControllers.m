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


#import "PFViewControllers.h"
#import "PFCoreComponents.h"
#import "TyphoonCollaboratingAssemblyProxy.h"
#import "TyphoonInitializer.h"
#import "TyphoonDefinition.h"
#import "PFAddCityViewController.h"
#import "PFRootViewController.h"
#import "PFCitiesListViewController.h"
#import "PFThemeProvider.h"
#import "PFWeatherReportViewController.h"


@implementation PFViewControllers

- (void)resolveCollaboratingAssemblies
{
    _coreComponents = [TyphoonCollaboratingAssemblyProxy proxy];
    _themeProvider = [TyphoonCollaboratingAssemblyProxy proxy];
}

- (id)rootViewController
{
    return [TyphoonDefinition withClass:[PFRootViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithMainContentViewController:menuViewController:);
        [initializer injectWithDefinition:[self weatherReportController]];
        [initializer injectWithDefinition:[self menuStack]];
    } properties:^(TyphoonDefinition* definition)
    {
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id)menuStack
{
    return [TyphoonDefinition withClass:[UINavigationController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithRootViewController:);
        [initializer injectWithDefinition:[self citiesListController]];
    }];
}

- (id)citiesListController
{
    return [TyphoonDefinition withClass:[PFCitiesListViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithCityDao:theme:);
        [initializer injectWithDefinition:[_coreComponents cityDao]];
        [initializer injectWithDefinition:[_themeProvider currentTheme]];
    }];
}

- (id)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithWeatherClient:weatherReportDao:cityDao:theme:);
        [initializer injectWithDefinition:[_coreComponents weatherClient]];
        [initializer injectWithDefinition:[_coreComponents weatherReportDao]];
        [initializer injectWithDefinition:[_coreComponents cityDao]];
        [initializer injectWithDefinition:[_themeProvider currentTheme]];
    }];
}


- (id)addCityStack
{
    return [TyphoonDefinition withClass:[UINavigationController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithRootViewController:);
        [initializer injectWithDefinition:[self addCityViewController]];
    }];
}


- (id)addCityViewController
{
    return [TyphoonDefinition withClass:[PFAddCityViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithNibName:bundle:);
        [initializer injectWithValueAsText:@"AddCity" requiredTypeOrNil:[NSString class]];
        [initializer injectWithDefinition:[self mainBundle]];
    } properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(cityDao) withDefinition:[_coreComponents cityDao]];
        [definition injectProperty:@selector(weatherClient) withDefinition:[_coreComponents weatherClient]];
    }];
}

- (id)mainBundle
{
    return [TyphoonDefinition withClass:[NSBundle class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(mainBundle);
    }];
}

@end