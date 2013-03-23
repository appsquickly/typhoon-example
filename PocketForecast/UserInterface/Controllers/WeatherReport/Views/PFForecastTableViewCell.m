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

#import "PFForecastTableViewCell.h"


@implementation PFForecastTableViewCell

/* ============================================================ Initializers ============================================================ */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
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

/* ========================================================== Interface Methods ========================================================= */
- (void)layoutIfNeeded
{
    [super layoutSubviews];
    _overlayView.frame = self.bounds;
}

/* ============================================================ Private Methods ========================================================= */
- (void)initBackgroundView
{
    UIView* backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setBackgroundColor:UIColorFromRGB(0x837758)];
    [self setBackgroundView:backgroundView];
}

- (void)initOverlay
{
    _overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [_overlayView setImage:[UIImage imageNamed:@"cell_fade"]];
    [_overlayView setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:_overlayView];
}

- (void)initConditionsIcon
{
    _conditionsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(6, 10, 60 - 12, 50 - 12)];
    [_conditionsIcon setClipsToBounds:YES];
    [_conditionsIcon setContentMode:UIViewContentModeScaleAspectFit];
    [_conditionsIcon setImage:[UIImage imageNamed:@"icon_cloudy"]];
    [self addSubview:_conditionsIcon];
}

- (void)initDayLabel
{

}

- (void)initDescriptionLabel
{

}

- (void)initHighTempLabel
{

}

- (void)initLowTempLabel
{

}



@end