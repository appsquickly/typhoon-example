////////////////////////////////////////////////////////////////////////////////
//
//  AppsQuick.ly
//  Copyright 2013 AppsQuick.ly
//  All Rights Reserved.
//
//  NOTICE: AppsQuick.ly permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



#import "PFAssembly+ViewControllers.h"
#import "Typhoon.h"
#import "PFCitiesListViewController.h"
#import "PFAddCityViewController.h"
#import "PFWeatherReportViewController.h"


@implementation PFAssembly (ViewControllers)

- (id)navigationController
{
    return [TyphoonDefinition withClass:[UINavigationController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithRootViewController:);
        [initializer injectWithDefinition:[self citiesListController]];
    } properties:^(TyphoonDefinition* definition)
    {
        [definition setAfterPropertyInjection:@selector(applySkin)];
        definition.lifecycle = TyphoonComponentLifeCyclePrototype;
    }];
}

- (id)citiesListController
{
    return [TyphoonDefinition withClass:[PFCitiesListViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithCityDao:);
        [initializer injectWithDefinition:[self cityDao]];
    } properties:^(TyphoonDefinition* definition)
    {
        definition.lifecycle = TyphoonComponentLifeCyclePrototype;
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
    } properties:^(TyphoonDefinition* definition)
    {
        definition.lifecycle = TyphoonComponentLifeCyclePrototype;
    }];
}

- (id)addCityViewController
{
    return [TyphoonDefinition withClass:[PFAddCityViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithNibName:bundle:);
        [initializer injectParameterAt:0 withValueAsText:@"AddCity" requiredTypeOrNil:[NSString class]];
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