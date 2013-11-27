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



#import <Foundation/Foundation.h>

typedef enum {
    PFTemperatureUnitsCelsius,
    PFTemperatureUnitsFahrenheit
} PFTemperatureUnits;

/**
* Models mark temperature in either fahrenheit or celsius. Does safe floating-point conversion between units.
*/
@interface PFTemperature : NSObject<NSCoding> {

    NSDecimalNumber* _temperatureInFahrenheit;
    NSNumberFormatter* _shortFormatter;
    NSNumberFormatter* _longFormatter;
}

+ (PFTemperature*) temperatureWithFahrenheitString:(NSString*)fahrenheitString;

+ (PFTemperature*) temperatureWithCelsiusString:(NSString*)celsiusString;

+ (void) setDefaultUnits:(PFTemperatureUnits)units;

+ (PFTemperatureUnits) defaultUnits;

- (id) initWithFahrenheitString:(NSString*)fahrenheitString;

- (id) initWithCelsiusString:(NSString*)celsiusString;

/**
* Returns the temperature in fahrenheit.
*/
- (NSNumber*) inFahrenheit;

/**
* Returns the temperature in celsius.
*/
- (NSNumber*) inCelsius;

/**
* Returns the temperature in default units, rounded as a whole number.
*/
- (NSString*) asShortStringInDefaultUnits;

/**
* Returns the temperature in default units, rounded to one decimal place.
*/
- (NSString*) asLongStringInDefaultUnits;

/**
* Returns the temperature in degrees fahrenheit, rounded as a whole number.
*/
- (NSString*) asShortStringInFahrenheit;

/**
* Returns the temperature in degrees fahrenheit, rounded to one decimal place.
*/
- (NSString*) asLongStringInFahrenheit;

/**
* Returns the temperature in degrees celsius, rounded as a whole number.
*/
- (NSString*) asShortStringInCelsius;

/**
* Returns the temperature in degrees celsius, rounded to one decimal place.
*/
- (NSString*) asLongStringInCelsius;


@end
