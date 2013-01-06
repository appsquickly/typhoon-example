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



#import <Foundation/Foundation.h>


@interface PFForecastConditionsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* dayLabel;
@property (nonatomic, weak) IBOutlet UILabel* lowLabel;
@property (nonatomic, weak) IBOutlet UILabel* highLabel;
@property (nonatomic, weak) IBOutlet UIImageView* weatherIconView;

@end