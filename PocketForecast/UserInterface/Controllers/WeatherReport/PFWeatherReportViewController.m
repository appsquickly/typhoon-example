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
#import "PFRootViewController.h"
#import "ICLoader.h"
#import "PFTheme.h"
#import "PFApplicationAssembly.h"


@implementation PFWeatherReportViewController


/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithView:(PFWeatherReportView *)view weatherClient:(id <PFWeatherClient>)weatherClient
    weatherReportDao:(id <PFWeatherReportDao>)weatherReportDao cityDao:(id <PFCityDao>)cityDao assembly:(PFApplicationAssembly *)assembly
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.view = view;
        _weatherClient = weatherClient;
        _weatherReportDao = weatherReportDao;
        _cityDao = cityDao;
        _assembly = assembly;
    }
    return self;
}

/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    _cityName = [_cityDao loadSelectedCity];
    _weatherReport = [_weatherReportDao getReportForCityName:_cityName];
    if (_weatherReport)
    {
        [self.view setWeatherReport:_weatherReport];
    }
    else if (_cityName)
    {
        [self refreshData];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (_cityName)
    {
        UIBarButtonItem *cityListButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(presentMenu)];
        [cityListButton setTintColor:[UIColor whiteColor]];

        UIBarButtonItem *space = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem *refreshButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
        [refreshButton setTintColor:[UIColor whiteColor]];

        [self.view.toolbar setItems:@[
            cityListButton,
            space,
            refreshButton
        ]];
    }
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
    __weak PFWeatherReportView *view = (PFWeatherReportView *) self.view;
    [ICLoader present];
    [_weatherClient loadWeatherReportFor:_cityName onSuccess:^(PFWeatherReport *report)
    {
        LogDebug(@"Got report: %@", report);
        [view setWeatherReport:report];
        [ICLoader dismiss];
    } onError:^(NSString *message)
    {
        [ICLoader dismiss];
        LogDebug(@"Error %@", message);
    }];
}

- (void)presentMenu
{
    //Here we could have injected the root controller itself, however its useful to see the TyphoonComponentFactory itself being injected,
    //and posing behind an assembly interface.

    [[_assembly rootViewController] toggleSideViewController];
}


@end
