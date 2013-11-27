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


#import "PFCurrentConditions.h"
#import "PFTemperature.h"


@implementation PFCurrentConditions

@synthesize summary = _summary;
@synthesize temperature = _temperature;
@synthesize humidity = _humidity;
@synthesize wind = _wind;
@synthesize imageUri = _imageUri;

/* ================================================= Class Methods ================================================== */
+ (PFCurrentConditions*) conditionsWithSummary:(NSString*)summary temperature:(PFTemperature*)temperature
        humidity:(NSString*)humidity wind:(NSString*)wind imageUrl:(NSString*)imageUrl {

    return [[PFCurrentConditions alloc]
            initWithSummary:summary temperature:temperature humidity:humidity wind:wind imageUri:imageUrl];
}


/* ================================================== Initializers ================================================== */
- (id) initWithSummary:(NSString*)summary temperature:(PFTemperature*)temperature humidity:(NSString*)humidity
        wind:(NSString*)wind imageUri:(NSString*)imageUri {
    self = [super init];
    if (self) {
        _summary = [summary copy];
        _temperature = temperature;
        _humidity = [humidity copy];
        _wind = [wind copy];
        _imageUri = [imageUri copy];
    }
    return self;
}

- (id) initWithCoder:(NSCoder*)coder {
    self = [super init];
    if (self) {
        _summary = [coder decodeObjectForKey:@"_summary"];
        _temperature = [coder decodeObjectForKey:@"_temperature"];
        _humidity = [coder decodeObjectForKey:@"_humidity"];
        _wind = [coder decodeObjectForKey:@"_wind"];
        _imageUri = [coder decodeObjectForKey:@"_imageUri"];
    }
    return  self;
}


/* ================================================ Interface Methods =============================================== */
- (NSString*) longSummary {
    return [NSString stringWithFormat:@"%@. %@.", _summary, _wind];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Current Conditions: summary=%@, temperature=%@", _summary, _temperature];
}

- (void) encodeWithCoder:(NSCoder*)coder {
    [coder encodeObject:_summary forKey:@"_summary"];
    [coder encodeObject:_temperature forKey:@"_temperature"];
    [coder encodeObject:_humidity forKey:@"_humidity"];
    [coder encodeObject:_wind forKey:@"_wind"];
    [coder encodeObject:_imageUri forKey:@"_imageUri"];
}


@end