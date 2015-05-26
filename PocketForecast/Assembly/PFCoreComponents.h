////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2015, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@protocol PFWeatherClient;
@protocol PFCityDao;
@protocol PFWeatherReportDao;


@interface PFCoreComponents : TyphoonAssembly


- (id<PFWeatherClient>)weatherClient;

- (id<PFWeatherReportDao>)weatherReportDao;

- (id<PFCityDao>)cityDao;

@end