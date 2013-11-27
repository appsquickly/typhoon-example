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



#import "RXMLElement+PFWeatherReport.h"
#import "PFWeatherReport.h"
#import "PFCurrentConditions.h"
#import "PFTemperature.h"
#import "PFForecastConditions.h"


@implementation RXMLElement (PFWeatherReport)

- (PFWeatherReport*)asWeatherReport
{
    if (![self.tag isEqualToString:@"data"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Element is not 'data'."];
    }

    NSString* city = [[self child:@"request.query"] text];
    PFCurrentConditions* currentConditions = [[self child:@"current_condition"] asCurrentCondition];

    NSMutableArray* forecast = [[NSMutableArray alloc] init];
    for (RXMLElement* e in [self children:@"weather"])
    {
        [forecast addObject:[e asForecastConditions]];
    }

    return [PFWeatherReport reportWithCity:city date:[NSDate date] currentConditions:currentConditions forecast:forecast];
}

    - (PFCurrentConditions*)asCurrentCondition
    {
        if (![self.tag isEqualToString:@"current_condition"])
        {
            [NSException raise:NSInvalidArgumentException format:@"Element is not 'current_condition'."];
        }

        NSString* summary = [[self child:@"weatherDesc"] text];
        PFTemperature* temp = [PFTemperature temperatureWithFahrenheitString:[[self child:@"temp_F"] text]];
        NSString* humidity = [[self child:@"humidity"] text];
        NSString* wind =
                [NSString stringWithFormat:@"Wind: %@ km %@", [[self child:@"windspeedKmph"] text], [[self child:@"winddir16Point"] text]];
        NSString* imageUri = [[self child:@"weatherIconUrl"] text];

        return [PFCurrentConditions conditionsWithSummary:summary temperature:temp humidity:humidity wind:wind imageUrl:imageUri];

    }

- (PFForecastConditions*)asForecastConditions
{
    if (![self.tag isEqualToString:@"weather"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Element is not 'weather'."];
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [formatter dateFromString:[[self child:@"date"] text]];
    PFTemperature* low = [PFTemperature temperatureWithFahrenheitString:[[self child:@"tempMinF"] text]];
    PFTemperature* high = [PFTemperature temperatureWithFahrenheitString:[[self child:@"tempMaxF"] text]];
    NSString* description = [[self child:@"weatherDesc"] text];
    NSString* imageUri = [[self child:@"weatherIconUrl"] text];

    return [PFForecastConditions conditionsWithDate:date low:low high:high summary:description imageUri:imageUri];
}


@end