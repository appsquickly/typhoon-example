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


@interface PFCurrentConditionsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel* temperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel* conditionsSummary;

@end