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


#import <Foundation/Foundation.h>


@interface PFForecastTableViewCell : UITableViewCell
{
    UIImageView* _conditionsIcon;
    UILabel* _dayLabel;
    UILabel* _descriptionLabel;
    UILabel* _highTempLabel;
    UILabel* _lowTempLabel;
    UIImageView* _overlayView;
}

@end