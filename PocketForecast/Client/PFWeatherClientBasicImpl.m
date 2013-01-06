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

/* =========================================================== Protocol Methods ========================================================= */
- (void)loadWeatherReportFor:(NSString*)city delegate:(id <PFWeatherClientDelegate>)delegate
{
    NSDictionary* parameters = [[NSMutableDictionary alloc] init];
    [parameters setValue:city forKey:@"q"];
    [parameters setValue:@"xml" forKey:@"format"];
    [parameters setValue:@"5" forKey:@"num_of_days"];
    LogDebug(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ Here's the api key: %@", _apiKey);
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
                NSString* failureReason = [[error child:@"msg"] text];
                if (failureReason.length == 0)
                {
                    failureReason = @"No info. Perhaps the city name is invalid?";
                }
                [self dispatchErrorWith:delegate statusCode:response.status failureReason:failureReason];
            }
            else
            {
                __autoreleasing PFWeatherReport* weatherReport = [rootElement asWeatherReport];
                [_weatherReportDao saveReport:weatherReport];
                [delegate requestDidFinishWithWeatherReport:weatherReport];
            }
        }
        else
        {
            [self dispatchErrorWith:delegate statusCode:response.status failureReason:[response asString]];
        }
    }];

}

/* ============================================================ Private Methods ========================================================= */
- (void)dispatchErrorWith:(id <PFWeatherClientDelegate>)delegate statusCode:(NSInteger)statusCode
            failureReason:(NSString*)failureReason
{

    LogDebug(@"Dispatching error with failure reason: %@", failureReason);
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:failureReason forKey:NSLocalizedFailureReasonErrorKey];
    [delegate requestDidFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:statusCode userInfo:userInfo]];
}


@end