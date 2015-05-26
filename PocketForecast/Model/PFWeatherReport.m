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


#import "PFWeatherReport.h"
#import "PFCurrentConditions.h"


@implementation PFWeatherReport


//-------------------------------------------------------------------------------------------
#pragma mark - Class Methods
//-------------------------------------------------------------------------------------------

+ (PFWeatherReport *)reportWithCity:(NSString *)city date:(NSDate *)date
    currentConditions:(PFCurrentConditions *)currentConditions forecast:(NSArray *)forecast
{

    return [[PFWeatherReport alloc] initWithCity:city date:date currentConditions:currentConditions forecast:forecast];
}


//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id)initWithCity:(NSString *)city date:(NSDate *)date currentConditions:(PFCurrentConditions *)currentConditions
    forecast:(NSArray *)forecast
{
    self = [super init];
    if (self) {
        _city = [city copy];
        _date = [date copy];
        _currentConditions = currentConditions;
        _forecast = [forecast copy];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _city = [coder decodeObjectForKey:@"_city"];
        _date = [coder decodeObjectForKey:@"_date"];
        _currentConditions = [coder decodeObjectForKey:@"_currentConditions"];
        _forecast = [coder decodeObjectForKey:@"_forecast"];
    }
    return self;
}


//-------------------------------------------------------------------------------------------
#pragma mark - Interface Methods
//-------------------------------------------------------------------------------------------

- (NSString *)cityDisplayName
{
    NSString *displayName;
    NSArray *components = [_city componentsSeparatedByString:@","];
    if ([components count] > 1) {
        displayName = [components objectAtIndex:0];
    }
    else {
        displayName = [_city capitalizedString];
    }
    return displayName;
}

- (NSString *)reportDateAsString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd',' yyyy 'at' hh:mm a"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return [dateFormatter stringFromDate:_date];
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"Weather Report: city=%@, current conditions = %@, forecast=%@", _city,
                                      _currentConditions, _forecast];
}

- (void)encodeWithCoder:(NSCoder *)coder
{

    [coder encodeObject:_city forKey:@"_city"];
    [coder encodeObject:_date forKey:@"_date"];
    [coder encodeObject:_currentConditions forKey:@"_currentConditions"];
    [coder encodeObject:_forecast forKey:@"_forecast"];
}


@end