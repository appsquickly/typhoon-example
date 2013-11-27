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



#import <SenTestingKit/SenTestingKit.h>
#import "PFWeatherClient.h"
#import "PFWeatherReport.h"
#import "Typhoon.h"

@interface PFWeatherClientTests : SenTestCase
@end

@implementation PFWeatherClientTests
{
    id <PFWeatherClient> weatherClient;
}

/* ====================================================================================================================================== */
#pragma mark - Invoking weather service methods

- (void)setUp
{
    TyphoonXmlComponentFactory* factory = [[TyphoonXmlComponentFactory alloc] initWithConfigFileName:@"Assembly.xml"];
    id <TyphoonResource> configurationProperties = [TyphoonBundleResource withName:@"Configuration.properties"];
    [factory attachMutator:[TyphoonPropertyPlaceholderConfigurer configurerWithResource:configurationProperties]];
    weatherClient = [factory componentForKey:@"weatherClient"];
}


- (void)test_should_retrieve_a_weather_report_given_a_valid_city
{
    __block PFWeatherReport* retrievedReport;

    [weatherClient loadWeatherReportFor:@"Manila" onSuccess:^(PFWeatherReport* weatherReport)
    {
        retrievedReport = weatherReport;
    } onError:^(NSUInteger statusCode, NSString* message)
    {
        LogDebug(@"Got this error: %@", message);
    }];

    [TyphoonTestUtils waitForCondition:^BOOL
    {
        typhoon_asynch_condition(retrievedReport != nil);
    } andPerformTests:^
    {
        LogDebug(@"################### Result: %@", retrievedReport);
        assertThat(retrievedReport.forecast, isNot(empty()));
    }];

}


- (void)test_should_trigger_the_error_handler_if_the_city_name_is_not_valid
{
    __block NSString* errorMessage;

    [weatherClient loadWeatherReportFor:@"Dooglefog" onSuccess:nil onError:^(NSUInteger statusCode, NSString* message)
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