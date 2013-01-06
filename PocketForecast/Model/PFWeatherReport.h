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

@class PFCurrentConditions;


@interface PFWeatherReport : NSObject<NSCoding>

@property(nonatomic, strong, readonly) NSString* city;
@property(nonatomic, strong, readonly) NSDate* date;
@property(nonatomic, strong, readonly) PFCurrentConditions* currentConditions;
@property(nonatomic, strong, readonly) NSArray* forecast;

+ (PFWeatherReport*) reportWithCity:(NSString*)city date:(NSDate*)date
        currentConditions:(PFCurrentConditions*)currentConditions forecast:(NSArray*)forecast;

- (id) initWithCity:(NSString*)city date:(NSDate*)date currentConditions:(PFCurrentConditions*)currentConditions
        forecast:(NSArray*)forecast;

/**
* Nicely formats the city name for display. Sometimes (for example when there are more than one city with the same
* name), Google will format it for us - returning the city name and discriminator. If this is the case, we'll accept
* the Google formatted result, which means cities like 'Rio de Janeiro' are formatted nicely, otherwise we'll just
* capitalize words.
*/
 - (NSString*) cityDisplayName;

/**
* Returns the report date as a localized PFTemperatureDefaultUnits.
*/
- (NSString*) reportDateAsString;

@end
