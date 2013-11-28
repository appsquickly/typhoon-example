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



#import "PFCitiesListViewController.h"
#import "PFCityDao.h"
#import "PFAddCityViewController.h"
#import "PFWeatherReportViewController.h"
#import "PFTemperature.h"
#import "PFCityLabelTableViewCell.h"
#import "Typhoon.h"
#import "UIFont+ApplicationFonts.h"
#import "PFRootViewController.h"


static int const CELSIUS_SEGMENT_INDEX = 0;
static int const FAHRENHEIT_SEGMENT_INDEX = 1;

@implementation PFCitiesListViewController

@synthesize citiesListTableView = _citiesListTableView;
@synthesize temperatureUnitsControl = _temperatureUnitsControl;


/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (id)initWithCityDao:(id <PFCityDao>)cityDao
{
    self = [super initWithNibName:@"CitiesList" bundle:[NSBundle mainBundle]];
    if (self)
    {
        _cityDao = cityDao;
    }

    return self;
}

- (void)dealloc
{
    NSLog(@"%@ in dealloc!", self);
}



/* ====================================================================================================================================== */
#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pocket Forecast"];

    self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity)];
    [_citiesListTableView setEditing:YES];

    [_temperatureUnitsControl addTarget:self action:@selector(saveTemperatureUnitPreference) forControlEvents:UIControlEventValueChanged];

    if ([PFTemperature defaultUnits] == PFTemperatureUnitsCelsius)
    {
        [_temperatureUnitsControl setSelectedSegmentIndex:CELSIUS_SEGMENT_INDEX];
    }
    else
    {
        [_temperatureUnitsControl setSelectedSegmentIndex:FAHRENHEIT_SEGMENT_INDEX];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_citiesListTableView deselectRowAtIndexPath:[_citiesListTableView indexPathForSelectedRow] animated:NO];
    [self refreshCitiesList];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/* ====================================================================================================================================== */
#pragma mark UITableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cities count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* reuseId = @"Cities";
    PFCityLabelTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil)
    {
        cell = [[PFCityLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.cityLabel.backgroundColor = [UIColor clearColor];
    cell.cityLabel.font = [UIFont applicationFontOfSize:16];
    cell.cityLabel.textColor = [UIColor darkGrayColor];
    cell.cityLabel.text = ([_cities objectAtIndex:indexPath.row]);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    NSString* cityName = [_cities objectAtIndex:indexPath.row];
    [_cityDao saveCurrentlySelectedCity:cityName];

    PFRootViewController* controller = [[TyphoonComponentFactory defaultFactory] componentForType:[PFRootViewController class]];
    [controller toggleSideViewController];

}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath*)indexPath
{

    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString* city = [_cities objectAtIndex:indexPath.row];
        [_cityDao deleteCity:city];
        [self refreshCitiesList];
    }
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (void)addCity
{
    PFRootViewController* rootViewController = [[TyphoonComponentFactory defaultFactory] componentForType:[PFRootViewController class]];
    [rootViewController showAddCitiesController];
}


- (void)refreshCitiesList
{
    _cities = [_cityDao listAllCities];
    [_citiesListTableView reloadData];
}

- (void)saveTemperatureUnitPreference
{
    if ([_temperatureUnitsControl selectedSegmentIndex] == CELSIUS_SEGMENT_INDEX)
    {
        [PFTemperature setDefaultUnits:PFTemperatureUnitsCelsius];
    }
    else
    {
        [PFTemperature setDefaultUnits:PFTemperatureUnitsFahrenheit];
    }
}


@end
