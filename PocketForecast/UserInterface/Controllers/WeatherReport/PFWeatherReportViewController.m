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
#import "PFCurrentConditions.h"
#import "PFForecastConditions.h"
#import "PFWeatherReportDao.h"
#import "PFCityDao.h"
#import "Typhoon.h"
#import "PFWeatherReportView.h"
#import "PFForecastTableViewCell.h"


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

    _tableView = view.tableView;
    _tableView.dataSource = self;
    _tableView.delegate = self;

    self.view = view;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [_presentCitiesViewButton setAction:@selector(presentCitiesView)];
    [_refreshReportButton setAction:@selector(retrieveRemoteReport)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [_activityIndicatorCell startAnimating];
    _cityName = [_cityDao getCurrentlySelectedCity];
    _weatherReport = [_weatherReportDao getReportForCityName:_cityName];
    if (_weatherReport)
    {
        [self presentReport:_weatherReport];
    }
    else
    {
        [self retrieveRemoteReport];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self clearStaleData];
}



/* ====================================================================================================================================== */
#pragma mark UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    PFForecastConditions* forecastConditions = [[_weatherReport forecast] objectAtIndex:indexPath.row];
    static NSString* reuseIdentifier = @"weatherForecast";
    PFForecastTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil)
    {
        cell = [[PFForecastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }

//    [cell.dayLabel setText:forecastConditions.longDayOfTheWeek];
//    [cell.lowLabel setText:[forecastConditions.low asShortStringInDefaultUnits]];
//    [cell.highLabel setText:[forecastConditions.high asShortStringInDefaultUnits]];
//    [cell.weatherIconView setImage:[self uiImageForImageUri:forecastConditions.imageUri]];
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
        editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell
        forRowAtIndexPath:(NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

/* ============================================================ Utility Methods ========================================================= */
- (void)dealloc
{
    NSLog(@"%@ in dealloc!", self);
}


/* ============================================================ Private Methods ========================================================= */
/**
* Clears all data from the controller - ready for reuse.
*/
- (void)clearStaleData
{
    _weatherReport = nil;
    [_tableView reloadData];
    [_currentConditionsImageView setImage:nil];
    [_statusMessageLabel setText:@""];
}

- (void)presentReport:(PFWeatherReport*)weatherReport
{
//    [_activityIndicatorCell stopAnimating];
    _weatherReport = weatherReport;
    [_tableView reloadData];
    [_currentConditionsImageView setImage:[self uiImageForImageUri:weatherReport.currentConditions.imageUri]];
    [_statusMessageLabel setText:[NSString stringWithFormat:@"Updated %@", [weatherReport reportDateAsString]]];
}

- (void)retrieveRemoteReport
{
    __weak PFWeatherReportViewController* weakSelf = self;
//    [_activityIndicatorCell startAnimating];
    [_weatherClient loadWeatherReportFor:_cityName onSuccess:^(PFWeatherReport* report)
    {
        [weakSelf presentReport:report];
    } onError:nil];
}

- (void)presentCitiesView
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


- (UIImage*)uiImageForImageUri:(NSString*)imageUri
{

    if ([imageUri length] > 0)
    {
        LogDebug(@"Retrieving image for URI: %@", imageUri);
        if ([imageUri hasSuffix:@"wsymbol_0001_sunny.png"])
        {
            return [UIImage imageNamed:@"icon_sunny"];
        }
        else if ([imageUri hasSuffix:@"wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"])
        {
            return [UIImage imageNamed:@"partly_cloudy"];
        }
        else if ([imageUri hasSuffix:@"/ig/images/weather/partly_cloudy.gif"])
        {
            return [UIImage imageNamed:@"partly_cloudy"];
        }
        else if ([imageUri hasSuffix:@"wsymbol_0004_black_low_cloud.png"])
        {
            return [UIImage imageNamed:@"icon_cloudy"];
        }
        else if ([imageUri hasSuffix:@"wsymbol_0017_cloudy_with_light_rain.png"])
        {
            return [UIImage imageNamed:@"icon_rainy"];
        }
        else
        {
            return [UIImage imageNamed:@"icon_sunny"];
        }
    }
    return nil;

}

@end