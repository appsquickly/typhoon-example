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


#import "PFForecastConditions.h"
#import "PFTemperature.h"


@implementation PFForecastConditions


/* =========================================================== Class Methods ============================================================ */
+ (PFForecastConditions*)conditionsWithDate:(NSDate*)date low:(PFTemperature*)low
        high:(PFTemperature*)high summary:(NSString*)summary imageUri:(NSString*)imageUri
{

    return [[PFForecastConditions alloc] initWithDate:date low:low high:high summary:summary imageUri:imageUri];
}


/* ============================================================ Initializers ============================================================ */
- (id)initWithDate:(NSDate*)date low:(PFTemperature*)low high:(PFTemperature*)high
        summary:(NSString*)summary imageUri:(NSString*)imageUri
{

    self = [super init];
    if (self)
    {
        _date = date;
        _low = low;
        _high = high;
        _summary = summary;
        _imageUri = imageUri;
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    if (self)
    {
        _date = [coder decodeObjectForKey:@"_date"];
        _low = [coder decodeObjectForKey:@"_low"];
        _high = [coder decodeObjectForKey:@"_high"];
        _summary = [coder decodeObjectForKey:@"_summary"];
        _imageUri = [coder decodeObjectForKey:@"_imageUri"];
    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (NSString*)longDayOfTheWeek
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    return [formatter stringFromDate:_date];
}


/* ============================================================ Utility Methods ========================================================= */
- (NSString*)description
{
    return [NSString stringWithFormat:@"Forcast: day=%@, low=%@, high=%@", [self longDayOfTheWeek], _low, _high];
}

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:_date forKey:@"_date"];
    [coder encodeObject:_low forKey:@"_low"];
    [coder encodeObject:_high forKey:@"_high"];
    [coder encodeObject:_summary forKey:@"_summary"];
    [coder encodeObject:_imageUri forKey:@"_imageUri"];
}

@end