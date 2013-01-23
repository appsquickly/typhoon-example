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



#import "PFAssembly.h"
#import "Typhoon.h"
#import "PFWeatherClientBasicImpl.h"

@implementation PFAssembly

- (id)weatherClient
{
    return [TyphoonDefinition withClass:[PFWeatherClientBasicImpl class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(serviceUrl) withValueAsText:@"http://free.worldweatheronline.com/feed/weather.ashx"];
        [definition injectProperty:@selector(apiKey) withValueAsText:@"$$YOUR_API_KEY_HERE$$"];
        [definition injectProperty:@selector(daysToRetrieve) withValueAsText:@"5"];
        [definition injectProperty:@selector(weatherReportDao) withDefinition:[self weatherReportDao]];
    }];
}


- (id)weatherReportDao
{
    return nil;
}

- (id)cityDao
{
    return nil;
}


@end