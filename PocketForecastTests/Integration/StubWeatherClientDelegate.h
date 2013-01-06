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



#import <Foundation/Foundation.h>
#import "PFWeatherClient.h"


@interface StubWeatherClientDelegate : NSObject<PFWeatherClientDelegate>

@property (nonatomic, strong, readonly) PFWeatherReport* weatherReport;
@property (nonatomic, strong, readonly) UIImage* weatherImage;
@property (nonatomic, strong, readonly) NSError* error;

@end