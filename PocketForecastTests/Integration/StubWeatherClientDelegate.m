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



#import "StubWeatherClientDelegate.h"
#import "PFWeatherReport.h"


@implementation StubWeatherClientDelegate

@synthesize weatherReport = _weatherReport;
@synthesize weatherImage = _weatherImage;
@synthesize error = _error;


- (void) requestDidFinishWithWeatherReport:(PFWeatherReport*)weatherReport {
    _weatherReport = weatherReport;
}

- (void) requestDidFinishWithImage:(UIImage*)image {
    _weatherImage = image;
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = error;
}


@end