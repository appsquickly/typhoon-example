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

@class LRRestyClient;
@protocol PFWeatherReportDao;


@interface PFWeatherClientBasicImpl : NSObject <PFWeatherClient>
{

    LRRestyClient* _client;
}

@property(nonatomic, strong) id <PFWeatherReportDao> weatherReportDao;
@property(nonatomic, strong) NSString* serviceUrl;
@property(nonatomic, strong) NSString* apiKey;


@end