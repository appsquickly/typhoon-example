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
    [_client get:_serviceUrl parameters:[self requestParameters:city] withBlock:^(LRRestyResponse* response)
    {
        if (response.status == 200)
        {
            RXMLElement* rootElement = [RXMLElement elementFromXMLData:response.responseData];
            RXMLElement* error = [rootElement child:@"error"];
            if (error)
            {
                NSString* failureReason = [[[error child:@"msg"] text] copy];
                errorBlock(response.status, failureReason.length == 0 ? @"Unexpected error." : failureReason);
            }
            else
            {
                __autoreleasing PFWeatherReport* weatherReport = [rootElement asWeatherReport];
                [_weatherReportDao saveReport:weatherReport];
                successBlock(weatherReport);
            }
        }
        else
        {
            errorBlock(response.status, [response asString]);
        }
    }];

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