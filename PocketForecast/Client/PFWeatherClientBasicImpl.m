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



#import "PFWeatherClientBasicImpl.h"
#import "RXMLElement+PFWeatherReport.h"
#import "PFWeatherReport.h"
#import "PFWeatherReportDao.h"
#import "TyphoonURLUtils.h"


@implementation PFWeatherClientBasicImpl

@synthesize weatherReportDao = _weatherReportDao;



/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)setApiKey:(NSString*)apiKey
{
    _apiKey = apiKey;
    if ([_apiKey isEqualToString:@"$$YOUR_API_KEY_HERE$$"])
    {
        [NSException raise:NSInvalidArgumentException
            format:@"Please get an API key from: http://free.worldweatheronline.com, and then edit 'Configuration.properties'"];
    }
}

/* ====================================================================================================================================== */
#pragma mark - Protocol Methods

- (void)loadWeatherReportFor:(NSString*)city onSuccess:(PFWeatherReportReceivedBlock)successBlock
    onError:(PFWeatherReportErrorBlock)errorBlock;
{
    if (city)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
        {
            NSData* data = [NSData dataWithContentsOfURL:[self queryURL:city]];
            RXMLElement* rootElement = [RXMLElement elementFromXMLData:data];
            RXMLElement* error = [rootElement child:@"error"];
            if (error && errorBlock)
            {
                NSString* failureReason = [[[error child:@"msg"] text] copy];
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    errorBlock(failureReason.length == 0 ? @"Unexpected error." : failureReason);
                });

            }
            else if (successBlock)
            {
                PFWeatherReport* weatherReport = [rootElement asWeatherReport];
                [_weatherReportDao saveReport:weatherReport];
                dispatch_async(dispatch_get_main_queue(), ^
                {
                    successBlock(weatherReport);
                });
            }
        });
    }

}



/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (NSURL*)queryURL:(NSString*)city
{
    NSURL* url = [TyphoonURLUtils URL:_serviceUrl appendedWithQueryParameters:@{
        @"q"           : city,
        @"format"      : @"xml",
        @"num_of_days" : [NSString stringWithFormat:@"%i", _daysToRetrieve],
        @"key"         : _apiKey
    }];
    return url;
}

@end