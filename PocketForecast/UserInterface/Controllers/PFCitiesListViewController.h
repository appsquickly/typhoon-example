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



#import <UIKit/UIKit.h>

@protocol PFCityDao;

@interface PFCitiesListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {

    id<PFCityDao> _cityDao;
    NSArray* _cities;
}

@property (nonatomic, weak) IBOutlet UITableView* citiesListTableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl* temperatureUnitsControl;

@end
