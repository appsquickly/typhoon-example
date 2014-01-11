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



#import <XCTest/XCTest.h>
#import "PFWeatherClient.h"
#import "PFWeatherReport.h"
#import "Typhoon.h"
#import "TyphoonTestUtils.h"

@interface PFWeatherClientTests : XCTestCase
@end

@implementation PFWeatherClientTests
{
    id <PFWeatherClient> weatherClient;
}

/* ====================================================================================================================================== */
#pragma mark - Invoking weather service methods

- (void)setUp
{
    TyphoonXmlComponentFactory* factory = [[TyphoonXmlComponentFactory alloc] initWithConfigFileName:@"CoreComponents.xml"];
    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachPostProcessor:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
    weatherClient = [factory componentForKey:@"weatherClient"];
}


- (void)test_should_retrieve_a_weather_report_given_a_valid_city
{
    __block PFWeatherReport* retrievedReport;

    [weatherClient loadWeatherReportFor:@"Manila" onSuccess:^(PFWeatherReport* weatherReport)
    {
        retrievedReport = weatherReport;
    } onError:^(NSString* message)
    {
        LogDebug(@"Got this error: %@", message);
    }];

    [TyphoonTestUtils waitForCondition:^BOOL
    {
        typhoon_asynch_condition(retrievedReport != nil);
    } andPerformTests:^
    {
        LogDebug(@"################### Result: %@", retrievedReport);
        assertThat(retrievedReport.forecast, isNot(isEmpty()));
    }];

}


- (void)test_should_trigger_the_error_handler_if_the_city_name_is_not_valid
{
    __block NSString* errorMessage;

    [weatherClient loadWeatherReportFor:@"Dooglefog" onSuccess:nil onError:^(NSString* message)
    {
        errorMessage = message;
    }];

    [TyphoonTestUtils waitForCondition:^BOOL
    {
        typhoon_asynch_condition(errorMessage != nil);
    } andPerformTests:^
    {
        assertThat(errorMessage, equalTo(@"Unable to find any matching weather location to the query submitted!"));
    }];

}


@end