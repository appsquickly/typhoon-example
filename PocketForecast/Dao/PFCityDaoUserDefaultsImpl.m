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


#import "PFCityDaoUserDefaultsImpl.h"


@implementation PFCityDaoUserDefaultsImpl


static NSString* const pfCitiesListKey = @"pfWeather.cities";
static NSString* const pfCurrentCityKey = @"pfWeather.currentCityKey";


/* ================================================== Initializers ================================================== */
- (id)init
{
    self = [super init];
    if (self)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
        _repositoryUpdated = YES;
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */

- (NSArray*)listAllCities
{

    NSArray* cities = [_defaults objectForKey:pfCitiesListKey];
    if (cities == nil)
    {
        cities = [NSArray arrayWithObjects:@"Manila", @"Wollongong", @"Sydney", @"Melbourne", @"Kuala Lumpur", @"London", @"San Francisco",
                                           nil];
        [_defaults setObject:cities forKey:pfCitiesListKey];
    }
    _repositoryUpdated = NO;
    return [cities sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)saveCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    BOOL canAddCity = YES;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            canAddCity = NO;
        }
    }
    if (canAddCity)
    {
        [cities addObject:name];
        [_defaults setObject:cities forKey:pfCitiesListKey];
        _repositoryUpdated = YES;
    }
}

- (void)deleteCity:(NSString*)name
{
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray* cities = [NSMutableArray arrayWithArray:[_defaults objectForKey:pfCitiesListKey]];
    NSString* cityToRemove = nil;
    for (NSString* city in cities)
    {
        if ([city caseInsensitiveCompare:name] == NSOrderedSame)
        {
            cityToRemove = city;
        }
    }
    [cities removeObject:cityToRemove];
    [_defaults setObject:cities forKey:pfCitiesListKey];
    _repositoryUpdated = YES;
}

- (void)saveCurrentlySelectedCity:(NSString*)cityName
{
    NSString* trimmed = [cityName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([trimmed length] > 0)
    {
        [_defaults setObject:cityName forKey:pfCurrentCityKey];
    }
}

- (void)clearCurrentlySelectedCity
{
    [_defaults setObject:nil forKey:pfCurrentCityKey];
}


- (NSString*)getCurrentlySelectedCity
{
    return [_defaults objectForKey:pfCurrentCityKey];
}

- (BOOL)repositoryUpdated
{
    return _repositoryUpdated;
}


@end