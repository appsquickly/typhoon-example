////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2012 - 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>
#import "RXMLElement.h"

@class PFWeatherReport;
@class PFCurrentConditions;
@class PFForecastConditions;

@interface RXMLElement (PFWeatherReport)

- (PFWeatherReport*) asWeatherReport;

- (PFCurrentConditions*)asCurrentCondition;

- (PFForecastConditions*) asForecastConditions;



@end