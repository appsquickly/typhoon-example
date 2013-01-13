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
    NSDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:city forKey:@"q"];
    [parameters setValue:@"xml" forKey:@"format"];
    [parameters setValue:@"5" forKey:@"num_of_days"];
    [parameters setValue:_apiKey forKey:@"key"];

    [_client get:_serviceUrl parameters:parameters withBlock:^(LRRestyResponse* response)
    {

        if (response.status == 200)
        {

            NSString* xmlResponse = [[NSString alloc] initWithData:response.responseData encoding:NSASCIIStringEncoding];
            LogDebug(@"XML response: %@", xmlResponse);

            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlResponse encoding:NSUTF8StringEncoding];
            RXMLElement* error = [rootElement child:@"error"];
            if (error)
            {
                NSString* failureReason = [[[error child:@"msg"] text] copy];
                if (failureReason.length == 0)
                {
                    failureReason = @"No info. Perhaps the city name is invalid?";
                }
                errorBlock(response.status, failureReason);
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


@end