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

@class PFTemperature;


@interface PFCurrentConditions : NSObject<NSCoding>

@property(nonatomic, strong, readonly) NSString* summary;
@property(nonatomic, strong, readonly) PFTemperature* temperature;
@property(nonatomic, strong, readonly) NSString* humidity;
@property(nonatomic, strong, readonly) NSString* wind;
@property(nonatomic, strong, readonly) NSString* imageUri;

+ (PFCurrentConditions*) conditionsWithSummary:(NSString*)summary temperature:(PFTemperature*)temperature
        humidity:(NSString*)humidity wind:(NSString*)wind imageUrl:(NSString*)imageUrl;

- (id) initWithSummary:(NSString*)summary temperature:(PFTemperature*)temperature humidity:(NSString*)humidity
        wind:(NSString*)wind imageUri:(NSString*)imageUri;

- (NSString*) longSummary;


@end