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



#import "PFTemperature.h"


static NSString* const PFTemperatureDefaultUnits = @"pfWeather.defaultTemperatureUnits";

@implementation PFTemperature


/* ================================================= Class Methods ================================================== */
+ (PFTemperature*) temperatureWithFahrenheitString:(NSString*)fahrenheitString {
    return [[PFTemperature alloc] initWithFahrenheitString:fahrenheitString];
}

+ (PFTemperature*) temperatureWithCelsiusString:(NSString*)celsiusString {
    return [[PFTemperature alloc] initWithCelsiusString:celsiusString];
}

+ (PFTemperatureUnits) defaultUnits {
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:PFTemperatureDefaultUnits];
}


+ (void) setDefaultUnits:(PFTemperatureUnits)units {
    [[NSUserDefaults standardUserDefaults] setInteger:units forKey:PFTemperatureDefaultUnits];
}


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _shortFormatter = [[NSNumberFormatter alloc] init];
        [_shortFormatter setMinimumFractionDigits:0];
        [_shortFormatter setMaximumFractionDigits:0];

        _longFormatter = [[NSNumberFormatter alloc] init];
        [_longFormatter setMinimumFractionDigits:0];
        [_longFormatter setMaximumFractionDigits:1];
    }
    return self;
}

- (id) initWithFahrenheitString:(NSString*)fahrenheitString {
    self = [self init];
    
    if (fahrenheitString  != nil) {
        _temperatureInFahrenheit = [NSDecimalNumber decimalNumberWithString:fahrenheitString];
    }
    
    return self;
}

- (id) initWithCelsiusString:(NSString*)celsiusString {

    self = [self init];
    NSDecimalNumber* temperatureInCelsius = [NSDecimalNumber decimalNumberWithString:celsiusString];
    NSDecimalNumber* nineOverFive = [[NSDecimalNumber decimalNumberWithString:@"9"]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"5"]];

    _temperatureInFahrenheit = [[temperatureInCelsius decimalNumberByMultiplyingBy:nineOverFive]
            decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:@"32"]];
    return self;

}

- (id) initWithCoder:(NSCoder*)coder {
    self = [self init];
    _temperatureInFahrenheit = [coder decodeObjectForKey:@"_temperatureInFahrenheit"];
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (NSNumber*) inFahrenheit {
    return _temperatureInFahrenheit;
}

- (NSNumber*) inCelsius {
    NSDecimalNumber* fiveOverNine = [[NSDecimalNumber decimalNumberWithString:@"5"]
            decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"9"]];
    return [[_temperatureInFahrenheit decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:@"32"]]
            decimalNumberByMultiplyingBy:fiveOverNine];
}


- (NSString*) asShortStringInDefaultUnits {
    if ([PFTemperature defaultUnits] == PFTemperatureUnitsCelsius) {
        return [self asShortStringInCelsius];
    }
    else {
        return [self asShortStringInFahrenheit];
    }
}

- (NSString*) asLongStringInDefaultUnits {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:PFTemperatureDefaultUnits] == 0) {
        return [self asLongStringInCelsius];
    }
    else {
        return [self asLongStringInFahrenheit];
    }
}


- (NSString*) asShortStringInFahrenheit {

    return [[_shortFormatter stringFromNumber:[self inFahrenheit]] stringByAppendingString:@"°"];
}

- (NSString*) asLongStringInFahrenheit {
    return [[_longFormatter stringFromNumber:[self inFahrenheit]] stringByAppendingString:@"°"];
}


- (NSString*) asShortStringInCelsius {
    return [[_shortFormatter stringFromNumber:[self inCelsius]] stringByAppendingString:@"°"];;
}

- (NSString*) asLongStringInCelsius {
    return [[_longFormatter stringFromNumber:[self inCelsius]] stringByAppendingString:@"°"];;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Temperature: %@f [%@ celsius]", [self asShortStringInFahrenheit],
                                      [self asShortStringInCelsius]];
}

- (void) encodeWithCoder:(NSCoder*)coder {
    [coder encodeObject:_temperatureInFahrenheit forKey:@"_temperatureInFahrenheit"];
}


@end