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

@class PFWeatherReport;
@protocol PFWeatherReportDao;
@protocol PFCityDao;


@interface PFWeatherReportViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{

    PFWeatherReport* _weatherReport;
    NSString* _cityName;
}

#pragma mark - Spring injected via initializer
@property(nonatomic, strong, readonly) id <PFWeatherClient> weatherClient;
@property(nonatomic, strong, readonly) id <PFWeatherReportDao> weatherReportDao;
@property(nonatomic, strong, readonly) id <PFCityDao> cityDao;

#pragma mark - Interface Builder injected properties.
@property(nonatomic, weak) IBOutlet UIBarButtonItem* presentCitiesViewButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem* refreshReportButton;
@property(nonatomic, weak) IBOutlet UILabel* statusMessageLabel;
@property(nonatomic, weak) IBOutlet UIImageView* currentConditionsImageView;

- (id)initWithWeatherClient:(id <PFWeatherClient>)weatherClient weatherReportDao:(id <PFWeatherReportDao>)weatherReportDao
        cityDao:(id <PFCityDao>)cityDao;


@end