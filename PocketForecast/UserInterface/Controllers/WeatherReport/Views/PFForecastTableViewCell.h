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

@class PFForecastConditions;


@interface PFForecastTableViewCell : UITableViewCell
{
    UIImageView *_overlayView;
}

@property(nonatomic, strong, readonly) UILabel *dayLabel;
@property(nonatomic, strong, readonly) UILabel *descriptionLabel;
@property(nonatomic, strong, readonly) UILabel *highTempLabel;
@property(nonatomic, strong, readonly) UILabel *lowTempLabel;
@property(nonatomic, strong, readonly) UIImageView *conditionsIcon;

@end