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

#import "PFWeatherReportView.h"
#import "UIFont+ApplicationFonts.h"


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
    }

    return self;
}


/* ========================================================== Interface Methods ========================================================= */
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

    [_tableView setFrame:CGRectMake(0, self.frame.size.height - _toolbar.frame.size.height - 153, 320, 153)];
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
    [_cityNameLabel setText:@"Manila"];
    [self addSubview:_cityNameLabel];
}

- (void)initConditionsDescriptionLabel
{
    _conditionsDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 40)];
    [_conditionsDescriptionLabel setFont:[UIFont applicationFontOfSize:16]];
    [_conditionsDescriptionLabel setTextColor:UIColorFromRGB(0xf9f7f4)];
    [_conditionsDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [_conditionsDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_conditionsDescriptionLabel setText:@"Rainy. Wind ENE 6 KM/h"];
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

    _conditionsDescriptionLabel = [[UILabel alloc] initWithFrame:_temperatureLabelContainer.bounds];
    [_conditionsDescriptionLabel setFont:[UIFont temperatureFontOfSize:35]];
    [_conditionsDescriptionLabel setTextColor:UIColorFromRGB(0x7f9588)];
    [_conditionsDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [_conditionsDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_conditionsDescriptionLabel setText:@"26"];

    [_temperatureLabelContainer addSubview:_conditionsDescriptionLabel];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [_tableView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:_tableView];
}

- (void)initToolbar
{
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    [_toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self addSubview:_toolbar];
}


@end