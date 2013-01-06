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
@class PFActivityIndicatorTableViewCell;
@protocol PFWeatherReportDao;
@protocol PFCityDao;


@interface PFWeatherReportViewController : UIViewController<PFWeatherClientDelegate, UITableViewDataSource,
        UITableViewDelegate> {

    id<PFWeatherClient> _weatherClient;
    id<PFWeatherReportDao> _weatherReportDao;
    id<PFCityDao> _cityDao;

    PFWeatherReport* _weatherReport;
    PFActivityIndicatorTableViewCell* _activityIndicatorCell;

    UIImage* _mostlyCloudyImage;
    UIImage* _sunnyImage;
    UIImage* _mostlySunnyImage;
    UIImage* _partlyCloudyImage;
    UIImage* _chanceOfStormImage;
    UIImage* _chanceOfRainImage;
}

@property(nonatomic, weak) IBOutlet UIBarButtonItem* presentCitiesViewButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem* refreshReportButton;
@property(nonatomic, weak) IBOutlet UITableView* weatherReportTableView;
@property(nonatomic, weak) IBOutlet UILabel* statusMessageLabel;
@property(nonatomic, weak) IBOutlet UITableViewCell* injectedTableViewCell;
@property(nonatomic, weak) IBOutlet UIImageView* currentConditionsImageView;

@property(nonatomic, strong) NSString* cityName;


@end