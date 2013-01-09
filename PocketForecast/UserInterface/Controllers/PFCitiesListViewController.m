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



#import "PFCitiesListViewController.h"
#import "PFCityDao.h"
#import "PFAddCityViewController.h"
#import "PFWeatherReportViewController.h"
#import "PFTemperature.h"
#import "SpringComponentFactory.h"
#import "SpringComponentDefinition.h"


static int const CELSIUS_SEGMENT_INDEX = 0;
static int const FAHRENHEIT_SEGMENT_INDEX = 1;

@implementation PFCitiesListViewController

@synthesize citiesListTableView = _citiesListTableView;
@synthesize temperatureUnitsControl = _temperatureUnitsControl;


/* ============================================================ Initializers ============================================================ */
- (id)initWithCityDao:(id <PFCityDao>)cityDao
{
    self = [super initWithNibName:@"CitiesList" bundle:[NSBundle mainBundle]];
    if (self)
    {
        _cityDao = cityDao;
    }

    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Pocket Forecast"];
    self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
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
    [self refreshCitiesList];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/* =========================================================== Protocol Methods ========================================================= */
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
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }

    NSString* city = [_cities objectAtIndex:indexPath.row];
    cell.textLabel.text = city;

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    NSString* cityName = [_cities objectAtIndex:indexPath.row];

    [_cityDao saveCurrentlySelectedCity:cityName];

    PFWeatherReportViewController
            * weatherReportController = [[SpringComponentFactory defaultFactory] componentForType:[PFWeatherReportViewController class]];
    [weatherReportController setCityName:cityName];

    [self moveFrameBelowStatusBarFor:weatherReportController];
    [self.navigationController removeFromParentViewController];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.9f];
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
    [window setRootViewController:weatherReportController];
    [UIView commitAnimations];

}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView
        editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
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

/* ============================================================ Utility Methods ========================================================= */
- (void)dealloc
{
    NSLog(@"%@ in dealloc!", self);
}

/* ============================================================ Private Methods ========================================================= */
- (void)addCity:(id)sender
{
    PFAddCityViewController* addCityController = [[SpringComponentFactory defaultFactory] componentForType:[PFAddCityViewController class]];
    [self presentViewController:addCityController animated:YES completion:^
    {

    }];
}

- (void)refreshCitiesList
{
    _cities = [_cityDao listAllCities];
    [_citiesListTableView reloadData];
}

/*
* When replacing the root view controller it's necessary to adjust a new view's frame below the status bar.
*/
- (void)moveFrameBelowStatusBarFor:(PFWeatherReportViewController*)weatherReportController
{
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGRect newFrame = weatherReportController.view.frame;
    newFrame.origin = CGPointMake(0, 0 + statusBarFrame.size.height);
    newFrame.size = CGSizeMake(self.view.frame.size.width, self.view.window.frame.size.height - statusBarFrame.size.height);
    weatherReportController.view.frame = newFrame;
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
