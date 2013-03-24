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



#import "PFWeatherReportViewController.h"
#import "PFWeatherReport.h"
#import "PFWeatherReportDao.h"
#import "PFCityDao.h"
#import "Typhoon.h"
#import "PFWeatherReportView.h"


@implementation PFWeatherReportViewController


/* ============================================================ Initializers ============================================================ */
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


/* ========================================================== Interface Methods ========================================================= */
- (void)loadView
{
    PFWeatherReportView* view = [[PFWeatherReportView alloc] initWithFrame:CGRectZero];
    [view sizeToFit];
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


/* ============================================================ Utility Methods ========================================================= */
- (void)dealloc
{
    Typhoon_LogDealloc();
}


/* ============================================================ Private Methods ========================================================= */
- (void)refreshData
{
    __weak PFWeatherReportView* view = (PFWeatherReportView*) self.view;
    [view showSpinner];
    [_weatherClient loadWeatherReportFor:_cityName onSuccess:^(PFWeatherReport* report)
    {
        LogDebug(@"Got report: %@", report);
        [view setWeatherReport:report];
        [view hideSpinner];
    } onError:nil];
}

- (void)presentCitiesList
{
    [_cityDao clearCurrentlySelectedCity];

    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    UINavigationController* controller = [[TyphoonComponentFactory defaultFactory] componentForType:[UINavigationController class]];
    //pre-load this, because it may not have loaded yet.
    assert(controller.visibleViewController.view != nil);

    [UIView transitionWithView:window duration:0.9f options:UIViewAnimationOptionTransitionFlipFromRight animations:^
    {
        [window setRootViewController:controller];
    } completion:nil];
}


@end