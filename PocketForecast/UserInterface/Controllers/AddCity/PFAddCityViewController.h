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
#import "PFWeatherClient.h"

@protocol PFCityDao;
@protocol PFWeatherClient;


@interface PFAddCityViewController : UIViewController <UITextFieldDelegate>


#pragma mark - Container injected properties.
@property(nonatomic, strong) id <PFCityDao> cityDao;
@property(nonatomic, strong) id <PFWeatherClient> weatherClient;


#pragma mark - Interface Builder injected properties
@property(nonatomic, weak) IBOutlet UITextField* nameOfCityToAdd;
@property(nonatomic, weak) IBOutlet UIBarButtonItem* doneButton;
@property(nonatomic, weak) IBOutlet UILabel* validationMessage;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* spinner;

- (void)validateRequiredProperties;

@end