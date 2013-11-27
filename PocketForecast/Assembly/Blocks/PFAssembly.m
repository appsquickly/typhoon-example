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
#import "Typhoon.h"
#import "PFWeatherClientBasicImpl.h"
#import "PFWeatherReportDaoFileSystemImpl.h"
#import "PFCityDaoUserDefaultsImpl.h"

@implementation PFAssembly

- (id)weatherClient
{
    return [TyphoonDefinition withClass:[PFWeatherClientBasicImpl class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(serviceUrl) withValueAsText:@"${service.url}"];
        [definition injectProperty:@selector(apiKey) withValueAsText:@"${api.key}"];
        [definition injectProperty:@selector(daysToRetrieve) withValueAsText:@"${days.to.retrieve}"];
        [definition injectProperty:@selector(weatherReportDao) withDefinition:[self weatherReportDao]];
    }];
}


- (id)weatherReportDao
{
    return [TyphoonDefinition withClass:[PFWeatherReportDaoFileSystemImpl class]];
}

- (id)cityDao
{
    return [TyphoonDefinition withClass:[PFCityDaoUserDefaultsImpl class]];
}


@end