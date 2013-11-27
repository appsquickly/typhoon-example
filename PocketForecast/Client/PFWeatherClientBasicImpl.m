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
#import "LRRestyResponse.h"
#import "LRResty.h"
#import "RXMLElement+PFWeatherReport.h"
#import "PFWeatherReport.h"
#import "PFWeatherReportDao.h"
#import "NSURL+TyphoonUtils.h"


@implementation PFWeatherClientBasicImpl

@synthesize weatherReportDao = _weatherReportDao;


/* ============================================================ Initializers ============================================================ */
- (id)init
{
    self = [super init];
    if (self)
    {
        _client = [LRResty client];
    }

    return self;
}

/* ========================================================== Interface Methods ========================================================= */
- (void)setApiKey:(NSString*)apiKey
{
    _apiKey = apiKey;
    if ([_apiKey isEqualToString:@"$$YOUR_API_KEY_HERE$$"])
    {
        [NSException raise:NSInvalidArgumentException format:@"Please get an API key from: http://free.worldweatheronline.com"];
    }
}

/* =========================================================== Protocol Methods ========================================================= */
- (void)loadWeatherReportFor:(NSString*)city onSuccess:(PFWeatherReportReceivedBlock)successBlock
    onError:(PFWeatherReportErrorBlock)errorBlock;
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
    {
        NSData* data = [NSData dataWithContentsOfURL:[_serviceUrl URLByAppendingQueryParameters:[self requestParameters:city]]];
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

/* ============================================================ Private Methods ========================================================= */
- (NSDictionary*)requestParameters:(NSString*)city
{
    NSDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:city forKey:@"q"];
    [parameters setValue:@"xml" forKey:@"format"];
    [parameters setValue:[NSString stringWithFormat:@"%i", _daysToRetrieve] forKey:@"num_of_days"];
    [parameters setValue:_apiKey forKey:@"key"];
    return parameters;
}


@end