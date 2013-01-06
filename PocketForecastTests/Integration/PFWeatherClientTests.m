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
#import "PFWeatherClient.h"
#import "StubWeatherClientDelegate.h"
#import "SpringXmlComponentFactory.h"

@interface PFWeatherClientTests : SenTestCase
@end

@implementation PFWeatherClientTests
{
    id <PFWeatherClient> weatherClient;
    StubWeatherClientDelegate* delegate;
}

/* ====================================================================================================================================== */
#pragma mark - Invoking weather service methods

- (void)setUp
{
    SpringXmlComponentFactory* factory = [[SpringXmlComponentFactory alloc] initWithConfigFileName:@"Assembly.xml"];
    weatherClient = [factory componentForKey:@"weatherClient"];
    delegate = [[StubWeatherClientDelegate alloc] init];
}


- (void)test_should_retrieve_a_weather_report_given_a_valid_city
{
    [weatherClient loadWeatherReportFor:@"Manila" delegate:delegate];
    assertWillHappen(delegate.weatherReport != nil);
    LogDebug(@"################### Result: %@", delegate.weatherReport);
}


- (void)test_should_trigger_the_error_handler_if_the_city_name_is_not_valid
{
    [weatherClient loadWeatherReportFor:@"Dooglefog" delegate:delegate];
    assertWillHappen(delegate.error != nil);
    assertThat(delegate.error.localizedFailureReason, equalTo(@"Unable to find any matching weather location to the query submitted!"));
}


@end