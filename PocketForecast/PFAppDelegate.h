////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import <UIKit/UIKit.h>

@protocol PFCityDao;
@class PFRootViewController;

@interface PFAppDelegate : UIResponder <UIApplicationDelegate>


@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, strong) id <PFCityDao> cityDao;
@property(nonatomic, strong) PFRootViewController *rootViewController;


@end
