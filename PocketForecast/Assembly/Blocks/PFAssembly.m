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


#import "PFAssembly.h"
#import "PFCoreComponents.h"
#import "PFAddCityViewController.h"
#import "PFRootViewController.h"
#import "PFCitiesListViewController.h"
#import "PFThemeProvider.h"
#import "PFWeatherReportViewController.h"


@implementation PFAssembly

- (id)rootViewController
{
    return [TyphoonDefinition withClass:[PFRootViewController class] configuration:^(TyphoonDefinition* definition)
    {
        [definition useInitializer:@selector(initWithMainContentViewController:) parameters:^(TyphoonMethod* initializer)
        {
            [initializer injectParameterWith:[self weatherReportController]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}


- (id)citiesListController
{
    return [TyphoonDefinition withClass:[PFCitiesListViewController class] configuration:^(TyphoonDefinition* definition)
    {
        [definition useInitializer:@selector(initWithCityDao:theme:) parameters:^(TyphoonMethod* initializer)
        {
            [initializer injectParameterWith:[_coreComponents cityDao]];
            [initializer injectParameterWith:[_themeProvider currentTheme]];
        }];
        [definition injectProperty:@selector(assembly)];
    }];
}

- (id)weatherReportController
{
    return [TyphoonDefinition withClass:[PFWeatherReportViewController class] configuration:^(TyphoonDefinition* definition)
    {
        [definition useInitializer:@selector(initWithWeatherClient:weatherReportDao:cityDao:theme:) parameters:^(TyphoonMethod* initializer)
        {
            [initializer injectParameterWith:[_coreComponents weatherClient]];
            [initializer injectParameterWith:[_coreComponents weatherReportDao]];
            [initializer injectParameterWith:[_coreComponents cityDao]];
            [initializer injectParameterWith:[_themeProvider currentTheme]];
        }];
    }];
}

- (id)addCityViewController
{
    return [TyphoonDefinition withClass:[PFAddCityViewController class] configuration:^(TyphoonDefinition* definition)
    {
        [definition useInitializer:@selector(initWithNibName:bundle:) parameters:^(TyphoonMethod* initializer)
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