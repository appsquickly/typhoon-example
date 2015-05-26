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



#import <UIKit/UIKit.h>

@protocol PFCityDao;
@class PFTheme;
@class FUISegmentedControl;
@class PFApplicationAssembly;

@interface PFCitiesListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _cities;
}

@property(nonatomic, strong, readonly) id <PFCityDao> cityDao;
@property(nonatomic, strong, readonly) PFTheme* theme;
@property(nonatomic, strong) PFApplicationAssembly * assembly;

@property(nonatomic, weak) IBOutlet UITableView* citiesListTableView;
@property(nonatomic, weak) IBOutlet UISegmentedControl* temperatureUnitsControl;

- (id)initWithCityDao:(id <PFCityDao>)cityDao theme:(PFTheme*)theme;


@end
