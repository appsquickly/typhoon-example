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

@class PFWeatherReport;
@protocol PFWeatherReportViewDelegate;


@interface PFWeatherReportView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView* _backgroundView;
    UILabel* _cityNameLabel;
    UILabel* _conditionsDescriptionLabel;
    UIImageView* _conditionsIcon;

    UIView* _temperatureLabelContainer;
    UILabel* _temperatureLabel;

    UILabel* _lastUpdateLabel;
    UITableView* _tableView;

    PFWeatherReport* _weatherReport;

    __weak id <PFWeatherReportViewDelegate> _delegate;

}

@property (nonatomic, strong, readonly) UIToolbar* toolbar;

- (void)setWeatherReport:(PFWeatherReport*)weatherReport;

- (void)setDelegate:(id <PFWeatherReportViewDelegate>)delegate;

@end