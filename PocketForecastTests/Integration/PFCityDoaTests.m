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


#import <SenTestingKit/SenTestingKit.h>
#import "PFCityDao.h"
#import "TyphoonXmlComponentFactory.h"

@interface PFCityDoaTests : SenTestCase
@end

@implementation PFCityDoaTests
{
    id <PFCityDao> cityDao;
}

/* ====================================================================================================================================== */
#pragma mark - Invoking create, list, delete methods on the City Data Access object


- (void)setUp
{
    TyphoonXmlComponentFactory* factory = [[TyphoonXmlComponentFactory alloc] initWithConfigFileName:@"Assembly.xml"];
    cityDao = [factory componentForKey:@"cityDao"];
}


- (void)test_should_list_all_cities_alphabetically
{
    NSArray* cities = [cityDao listAllCities];
    assertThat(cities, isNot(empty()));
}


- (void)test_should_allow_adding_a_city
{
    [cityDao saveCity:@"Manila"];

    NSArray* cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, isNot(empty()));

    //Adding the same city twice doesn't add an extra item.
    NSUInteger citiesCount = [cities count];
    [cityDao saveCity:@"Manila"];
    cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, hasCountOf(citiesCount));

}

- (void)test_should_allow_removing_a_city
{
    [cityDao deleteCity:@"Manila"];
    NSArray* cities = [cityDao listAllCities];
    LogDebug(@"Cities now: %@", cities);
    assertThat(cities, isNot(empty()));

    //Deleting a city that doesn't exist just gets ignored.
    [cityDao deleteCity:@"A City In The Sky - Part Coney Island and Part Paris"];

}


@end