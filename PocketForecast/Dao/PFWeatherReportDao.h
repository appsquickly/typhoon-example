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



@class PFWeatherReport;

@protocol PFWeatherReportDao<NSObject>

- (PFWeatherReport*) getReportForCityName:(NSString*)cityName;

- (void) saveReport:(PFWeatherReport*)weatherReport;

@end