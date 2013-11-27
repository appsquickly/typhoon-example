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
@property(nonatomic) int daysToRetrieve;


@end