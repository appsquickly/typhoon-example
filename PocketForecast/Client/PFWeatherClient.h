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


@class PFWeatherReport;

/**
* Block protocol for handling asynchronous responses from PFWeatherClient
*/

typedef void(^PFWeatherReportReceivedBlock)(PFWeatherReport* report);

typedef void(^PFWeatherReportErrorBlock)(NSUInteger errorCode, NSString* message);

/* ================================================================================================================== */

/**
* Protocol specifying the retrieval of weather forecast information.
*/
@protocol PFWeatherClient <NSObject>

- (void)loadWeatherReportFor:(NSString*)city onSuccess:(PFWeatherReportReceivedBlock)successBlock
        onError:(PFWeatherReportErrorBlock)errorBlock;

@end