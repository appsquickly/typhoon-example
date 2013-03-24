////////////////////////////////////////////////////////////////////////////////
//
//  JASPER BLUES
//  Copyright 2013 Jasper Blues
//  All Rights Reserved.
//
//  NOTICE: Jasper Blues permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import <CoreGraphics/CoreGraphics.h>
#import "PFWeatherReportView.h"
#import "UIFont+ApplicationFonts.h"
#import "PFForecastTableViewCell.h"
#import "PFForecastConditions.h"
#import "PFWeatherReport.h"
#import "PFCurrentConditions.h"
#import "PFTemperature.h"


@implementation PFWeatherReportView

/* ============================================================ Initializers ============================================================ */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initBackgroundView];
        [self initCityNameLabel];
        [self initConditionsDescriptionLabel];
        [self initConditionsIcon];
        [self initTemperatureLabel];
        [self initTableView];
        [self initToolbar];
        [self initLastUpdateLabel];
    }

    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)setWeatherReport:(PFWeatherReport*)weatherReport
{
    _weatherReport = weatherReport;
    [_tableView reloadData];
    [_cityNameLabel setText:[_weatherReport cityDisplayName]];
    [_temperatureLabel setText:[_weatherReport.currentConditions.temperature asShortStringInDefaultUnits]];
    [_conditionsDescriptionLabel setText:[_weatherReport.currentConditions longSummary]];
    [_conditionsIcon setImage:[self uiImageForImageUri:weatherReport.currentConditions.imageUri]];
    [_lastUpdateLabel setText:[NSString stringWithFormat:@"Updated %@", [weatherReport reportDateAsString]]];
}


- (void)sizeToFit
{
    [super sizeToFit];
    self.frame = [UIScreen mainScreen].bounds;
    LogDebug(@"my frame: %@", NSStringFromCGRect(self.frame));
    [self setNeedsLayout];
    LogDebug(@"Done sizing");
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    LogDebug(@"Layout views");
    [_toolbar setFrame:CGRectMake(0, self.frame.size.height - 44, 320, 44)];
    [_tableView setFrame:CGRectMake(0, self.frame.size.height - _toolbar.frame.size.height - 150, 320, 150)];
    [_lastUpdateLabel setFrame:CGRectMake(20, self.frame.size.height - 44, self.frame.size.width - 40, 44)];
}

/* =========================================================== Protocol Methods ========================================================= */
#pragma mark <UITableVieDelegate> & <UITableViewDataSource>

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

    [cell.dayLabel setText:forecastConditions.longDayOfTheWeek];
    [cell.descriptionLabel setText:forecastConditions.summary];
    [cell.lowTempLabel setText:[forecastConditions.low asShortStringInDefaultUnits]];
    [cell.highTempLabel setText:[forecastConditions.high asShortStringInDefaultUnits]];
    [cell.conditionsIcon setImage:[self uiImageForImageUri:forecastConditions.imageUri]];

    [cell.backgroundView setBackgroundColor:[self colorForRow:indexPath.row]];
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

/* ============================================================ Private Methods ========================================================= */
- (void)initBackgroundView
{
    _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"photo_background"]];
    [_backgroundView setFrame:CGRectMake(0, 0, 320, 285)];
    [self addSubview:_backgroundView];
}

- (void)initCityNameLabel
{
    _cityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 40)];
    [_cityNameLabel setFont:[UIFont applicationFontOfSize:35]];
    [_cityNameLabel setTextColor:UIColorFromRGB(0xf9f7f4)];
    [_cityNameLabel setBackgroundColor:[UIColor clearColor]];
    [_cityNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_cityNameLabel];
}

- (void)initConditionsDescriptionLabel
{
    _conditionsDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 40)];
    [_conditionsDescriptionLabel setFont:[UIFont applicationFontOfSize:16]];
    [_conditionsDescriptionLabel setTextColor:UIColorFromRGB(0xf9f7f4)];
    [_conditionsDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [_conditionsDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_conditionsDescriptionLabel];
}

- (void)initConditionsIcon
{
    _conditionsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 123, 130, 120)];
    [_conditionsIcon setImage:[UIImage imageNamed:@"icon_cloudy"]];
    [self addSubview:_conditionsIcon];
}

- (void)initTemperatureLabel
{
    _temperatureLabelContainer = [[UIView alloc] initWithFrame:CGRectMake(180, 135, 88, 88)];
    [self addSubview:_temperatureLabelContainer];

    UIImageView* labelBackground = [[UIImageView alloc] initWithFrame:_temperatureLabelContainer.bounds];
    [labelBackground setImage:[UIImage imageNamed:@"temperature_circle"]];
    [_temperatureLabelContainer addSubview:labelBackground];

    _temperatureLabel = [[UILabel alloc] initWithFrame:_temperatureLabelContainer.bounds];
    [_temperatureLabel setFont:[UIFont temperatureFontOfSize:35]];
    [_temperatureLabel setTextColor:UIColorFromRGB(0x7f9588)];
    [_temperatureLabel setBackgroundColor:[UIColor clearColor]];
    [_temperatureLabel setTextAlignment:NSTextAlignmentCenter];

    [_temperatureLabelContainer addSubview:_temperatureLabel];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setAllowsSelection:NO];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_tableView setBackgroundColor:[UIColor blackColor]];
    [_tableView setBounces:NO];
    [self addSubview:_tableView];
}

- (void)initToolbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [_toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self addSubview:_toolbar];

    UIBarButtonItem* cityListButton = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(cityListPressed)];

    UIBarButtonItem* space = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(cityListPressed)];

    UIBarButtonItem* refreshButton =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshPressed)];

    [_toolbar setItems:@[cityListButton, space, refreshButton]];
}

- (void)initLastUpdateLabel
{
    _lastUpdateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [_lastUpdateLabel setFont:[UIFont applicationFontOfSize:12]];
    [_lastUpdateLabel setTextColor:UIColorFromRGB(0xf9f7f4)];
    [_lastUpdateLabel setBackgroundColor:[UIColor clearColor]];
    [_lastUpdateLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_lastUpdateLabel];
}

/* ====================================================================================================================================== */

- (UIColor*)colorForRow:(NSUInteger)row
{
    switch (row)
    {
        case 0:
            return UIColorFromRGB(0x837758);
        case 1:
            return UIColorFromRGB(0x564e3a);
        default:
            return UIColorFromRGB(0x342e22);
    }
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
            return [UIImage imageNamed:@"icon_cloudy"];
        }
        else if ([imageUri hasSuffix:@"/ig/images/weather/partly_cloudy.gif"])
        {
            return [UIImage imageNamed:@"icon_cloudy"];
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

/* ====================================================================================================================================== */
#pragma mark - Actions

- (void)cityListPressed
{

}

- (void)refreshPressed
{

}

@end