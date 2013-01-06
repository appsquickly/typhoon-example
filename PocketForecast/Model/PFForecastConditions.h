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

@class PFTemperature;


@interface PFForecastConditions : NSObject <NSCoding>

@property(nonatomic, strong, readonly) NSDate* date;
@property(nonatomic, strong, readonly) PFTemperature* low;
@property(nonatomic, strong, readonly) PFTemperature* high;
@property(nonatomic, strong, readonly) NSString* summary;
@property(nonatomic, strong, readonly) NSString* imageUri;

+ (PFForecastConditions*)conditionsWithDate:(NSDate*)date low:(PFTemperature*)low
        high:(PFTemperature*)high summary:(NSString*)summary imageUri:(NSString*)imageUri;

- (id)initWithDate:(NSDate*)date low:(PFTemperature*)low high:(PFTemperature*)high
        summary:(NSString*)summary imageUri:(NSString*)imageUri;

- (NSString*)longDayOfTheWeek;

@end