////////////////////////////////////////////////////////////////////////////////
//
//  58 NORTH
//  Copyright 2013 58 North
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of 58 North
//  Use is subject to license terms.
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
#import "PFWeatherReportViewController.h"


@implementation PFViewControllers

- (void)resolveCollaboratingAssemblies
{
    _coreComponents = [TyphoonCollaboratingAssemblyProxy proxy];
}

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
        [initializer injectWithDefinition:[_coreComponents cityDao]];
    }];
}

- (id)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(initWithWeatherClient:weatherReportDao:cityDao:);
        [initializer injectWithDefinition:[_coreComponents weatherClient]];
        [initializer injectWithDefinition:[_coreComponents weatherReportDao]];
        [initializer injectWithDefinition:[_coreComponents cityDao]];
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