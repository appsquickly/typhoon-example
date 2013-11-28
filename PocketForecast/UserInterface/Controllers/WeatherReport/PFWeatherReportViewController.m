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




#import "PFWeatherReportViewController.h"
#import "PFWeatherReport.h"
#import "PFWeatherReportDao.h"
#import "PFCityDao.h"
#import "Typhoon.h"
#import "PFWeatherReportView.h"
#import "PFRootViewController.h"


@implementation PFWeatherReportViewController


/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithWeatherClient:(id <PFWeatherClient>)weatherClient weatherReportDao:(id <PFWeatherReportDao>)weatherReportDao
        cityDao:(id <PFCityDao>)cityDao
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _weatherClient = weatherClient;
        _weatherReportDao = weatherReportDao;
        _cityDao = cityDao;
    }
    return self;
}

- (void)dealloc
{
//    Typhoon_LogDealloc();
}

/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

- (void)loadView
{
    PFWeatherReportView* view = [[PFWeatherReportView alloc] initWithFrame:CGRectZero];
    self.view = view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [(PFWeatherReportView*) self.view setDelegate:self];
    _cityName = [_cityDao getCurrentlySelectedCity];
    _weatherReport = [_weatherReportDao getReportForCityName:_cityName];
    if (_weatherReport)
    {
        [(PFWeatherReportView*) self.view setWeatherReport:_weatherReport];
    }
    else
    {
        [self refreshData];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)refreshData
{
    __weak PFWeatherReportView* view = (PFWeatherReportView*) self.view;
    [view showSpinner];
    [_weatherClient loadWeatherReportFor:_cityName onSuccess:^(PFWeatherReport* report)
    {
        LogDebug(@"Got report: %@", report);
        [view setWeatherReport:report];
        [view hideSpinner];
    } onError:^(NSString* message)
    {
        [view hideSpinner];
        LogDebug(@"Error %@", message);
    }];
}

- (void)presentCitiesList
{
    [_cityDao clearCurrentlySelectedCity];

    PFRootViewController* controller = [[TyphoonComponentFactory defaultFactory] componentForType:[PFRootViewController class]];
    [controller toggleSideViewController];
}


@end
