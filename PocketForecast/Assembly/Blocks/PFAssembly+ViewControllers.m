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



#import "PFAssembly+ViewControllers.h"
#import "Typhoon.h"
#import "PFCitiesListViewController.h"
#import "PFAddCityViewController.h"
#import "PFWeatherReportViewController.h"
#import "PFRootViewController.h"


@implementation PFAssembly (ViewControllers)

- (id)rootViewController
{
    return [TyphoonDefinition withClass:[PFRootViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithMainContentViewController:sideViewController:);
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
        initializer.selector = @selector(initWithCityDao:);
        [initializer injectWithDefinition:[self cityDao]];
    }];
}

- (id)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithWeatherClient:weatherReportDao:cityDao:);
        [initializer injectWithDefinition:[self weatherClient]];
        [initializer injectWithDefinition:[self weatherReportDao]];
        [initializer injectWithDefinition:[self cityDao]];
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
        [definition injectProperty:@selector(cityDao) withDefinition:[self cityDao]];
        [definition injectProperty:@selector(weatherClient) withDefinition:[self weatherClient]];
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
