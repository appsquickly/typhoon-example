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
* Protocol for handling asynchronous responses from PFWeatherClient
*/
@protocol PFWeatherClientDelegate<NSObject>

@optional

- (void) requestDidFinishWithWeatherReport:(PFWeatherReport*)weatherReport;

- (void) requestDidFinishWithImage:(UIImage*)image;

- (void) requestDidFailWithError:(NSError*)error;

@end

/* ================================================================================================================== */

/**
* Protocol specifying the retrieval of weather forecast information.
*/
@protocol PFWeatherClient<NSObject>

- (void) loadWeatherReportFor:(NSString*)city delegate:(id<PFWeatherClientDelegate>)delegate;

@end