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




#import "PFAddCityViewController.h"
#import "PFCityDao.h"
#import "PFWeatherReport.h"
#import "UIFont+ApplicationFonts.h"
#import "TyphoonComponentFactory.h"
#import "PFRootViewController.h"


@implementation PFAddCityViewController

@synthesize nameOfCityToAdd = _nameOfCityToAdd;
@synthesize doneButton = _doneButton;
@synthesize validationMessage = _validationMessage;
@synthesize spinner = _spinner;


/* ============================================================ Initializers ============================================================ */
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}


/* ========================================================== Interface Methods ========================================================= */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameOfCityToAdd setFont:[UIFont applicationFontOfSize:16]];
    [_validationMessage setFont:[UIFont applicationFontOfSize:16]];

    [self setTitle:@"Add City"];
    self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAdding:)];
    [_nameOfCityToAdd becomeFirstResponder];
    [_doneButton setAction:@selector(doneAdding:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_validationMessage setHidden:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [self doneAdding:textField];
    return YES;
}

- (void)validateRequiredProperties
{
    if (!_weatherClient)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Property weatherClient is required."];
    }
    if (!_cityDao)
    {
        [NSException raise:NSInternalInconsistencyException format:@"Property cityDao is required."];
    }
}


/* ============================================================ Utility Methods ========================================================= */
- (void)dealloc
{
    NSLog(@"%@ in dealloc!", self);
}


/* ============================================================ Private Methods ========================================================= */
- (void)doneAdding:(id)sender
{
    PFRootViewController* rootViewController = [[TyphoonComponentFactory defaultFactory] componentForType:[PFRootViewController class]];
    if ([[_nameOfCityToAdd text] length] > 0)
    {
        [_validationMessage setText:@"Validating city . ."];
        [_nameOfCityToAdd setEnabled:NO];
        [_validationMessage setHidden:NO];
        [_spinner startAnimating];

        __weak id <PFCityDao> cityDao = _cityDao;

        [_weatherClient loadWeatherReportFor:[_nameOfCityToAdd text] onSuccess:^(PFWeatherReport* weatherReport)
        {
            LogDebug(@"Got weather report: %@", weatherReport);
            [cityDao saveCity:[weatherReport cityDisplayName]];
            [rootViewController dismissAddCitiesController];
        } onError:^(NSString* message)
        {
            [_spinner stopAnimating];
            [_nameOfCityToAdd setEnabled:YES];
            [_validationMessage setText:[NSString stringWithFormat:@"No weather reports for '%@'.", [_nameOfCityToAdd text]]];
        }];
    }
    else
    {
        [_nameOfCityToAdd resignFirstResponder];
        [rootViewController dismissAddCitiesController];
    }
}

@end