////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2015, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////



@class PFWeatherReport;

/**
* Block protocol for handling asynchronous responses from PFWeatherClient
*/

typedef void(^PFWeatherReportReceivedBlock)(PFWeatherReport* report);

typedef void(^PFWeatherReportErrorBlock)(NSString* message);

/* ====================================================================================================================================== */

/**
* Protocol specifying the retrieval of weather forecast information.
*/
@protocol PFWeatherClient <NSObject>

- (void)loadWeatherReportFor:(NSString*)city onSuccess:(PFWeatherReportReceivedBlock)successBlock
    onError:(PFWeatherReportErrorBlock)errorBlock;

@end