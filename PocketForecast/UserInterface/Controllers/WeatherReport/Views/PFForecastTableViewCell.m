////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2015, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "PFForecastTableViewCell.h"
#import "UIFont+ApplicationFonts.h"
#import "NanoFrame.h"


@implementation PFForecastTableViewCell

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initBackgroundView];
        [self initOverlay];
        [self initConditionsIcon];
        [self initDayLabel];
        [self initDescriptionLabel];
        [self initHighTempLabel];
        [self initLowTempLabel];
    }
    return self;
}

//-------------------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//-------------------------------------------------------------------------------------------

- (void)layoutSubviews {
    [super layoutSubviews];
    [_overlayView setFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
    [_conditionsIcon setFrame:CGRectMake(6, 7, 60 - 12, 50 - 12)];
    CGFloat iconContainerWidth = 7.0 / 32.0 * self.width;
    CGRect conditionsContainer = CGRectMake(0, 0, iconContainerWidth, self.contentView.height);
    [_conditionsIcon setFrame:CGRectInset(conditionsContainer, 8, 8)];
    [_dayLabel setX:iconContainerWidth + 10.0];
    [_dayLabel centerVerticallyInRect:self.contentView.frame];

    [_lowTempLabel centerVerticallyInRect:self.contentView.frame];
    [_lowTempLabel setRight:self.contentView.right - 10];
    [_highTempLabel centerVerticallyInRect:self.contentView.frame];
    [_highTempLabel setRight:_lowTempLabel.x - 5];
}


//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------

- (void)initBackgroundView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setBackgroundColor:[UIColor colorWithHexRGB:0x837758]];
    [self setBackgroundView:backgroundView];
}

- (void)initOverlay {
    _overlayView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_overlayView setImage:[UIImage imageNamed:@"cell_fade"]];
    [_overlayView setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:_overlayView];
}

- (void)initConditionsIcon {
    _conditionsIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_conditionsIcon setClipsToBounds:YES];
    [_conditionsIcon setContentMode:UIViewContentModeScaleAspectFit];
    [_conditionsIcon setImage:[UIImage imageNamed:@"icon_cloudy"]];
    [self.contentView addSubview:_conditionsIcon];
}

- (void)initDayLabel {
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 18)];
    [_dayLabel setFont:[UIFont applicationFontOfSize:16]];
    [_dayLabel setTextColor:[UIColor colorWithHexRGB:0xffffff]];
    [_dayLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_dayLabel];
}

- (void)initDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 16)];
    [_descriptionLabel setFont:[UIFont applicationFontOfSize:13]];
    [_descriptionLabel setTextColor:[UIColor colorWithHexRGB:0xe9e1cd]];
    [_descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_descriptionLabel];
}

- (void)initHighTempLabel {
    _highTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 30)];
    [_highTempLabel setFont:[UIFont temperatureFontOfSize:27]];
    [_highTempLabel setTextColor:[UIColor colorWithHexRGB:0xffffff]];
    [_highTempLabel setBackgroundColor:[UIColor clearColor]];
    [_highTempLabel setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:_highTempLabel];
}

- (void)initLowTempLabel {
    _lowTempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [_lowTempLabel setFont:[UIFont temperatureFontOfSize:20]];
    [_lowTempLabel setTextColor:[UIColor colorWithHexRGB:0xd9d1bd]];
    [_lowTempLabel setBackgroundColor:[UIColor clearColor]];
    [_lowTempLabel setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:_lowTempLabel];
}


@end