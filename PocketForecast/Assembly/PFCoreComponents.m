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


#import "PFCoreComponents.h"
#import "PFWeatherClientBasicImpl.h"
#import "PFWeatherReportDaoFileSystemImpl.h"
#import "PFCityDaoUserDefaultsImpl.h"
#import "TyphoonConfigPostProcessor.h"

@implementation PFCoreComponents

- (id <PFWeatherClient>)weatherClient
{
    return [TyphoonDefinition withClass:[PFWeatherClientBasicImpl class] configuration:^(TyphoonDefinition *definition)
    {
        [definition injectProperty:@selector(serviceUrl) with:TyphoonConfig(@"service.url")];
        [definition injectProperty:@selector(apiKey) with:TyphoonConfig(@"api.key")];
        [definition injectProperty:@selector(daysToRetrieve) with:TyphoonConfig(@"days.to.retrieve")];
        [definition injectProperty:@selector(weatherReportDao) with:[self weatherReportDao]];
    }];
}


- (id <PFWeatherReportDao>)weatherReportDao
{
    return [TyphoonDefinition withClass:[PFWeatherReportDaoFileSystemImpl class]];
}

- (id <PFCityDao>)cityDao
{
    return [TyphoonDefinition withClass:[PFCityDaoUserDefaultsImpl class] configuration:^(TyphoonDefinition *definition)
    {
        [definition useInitializer:@selector(initWithDefaults:) parameters:^(TyphoonMethod *initializer)
        {
            [initializer injectParameterWith:[NSUserDefaults standardUserDefaults]];
        }];
    }];
}


@end