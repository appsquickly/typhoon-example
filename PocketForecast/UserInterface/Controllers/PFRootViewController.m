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

#import "CKUITools.h"
#import "PFRootViewController.h"
#import "PFCitiesListViewController.h"
#import "PFAddCityViewController.h"
#import "PFApplicationAssembly.h"

#define SIDE_CONTROLLER_WIDTH 245.0

@implementation PFRootViewController

//-------------------------------------------------------------------------------------------
#pragma mark - Initialization & Destruction
//-------------------------------------------------------------------------------------------

- (instancetype)initWithMainContentViewController:(UIViewController *)mainContentViewController assembly:(PFApplicationAssembly *)assembly
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _assembly = assembly;
        _sideViewState = PFSideViewStateHidden;
        if (mainContentViewController)
        {
            [self pushViewController:mainContentViewController replaceRoot:YES];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithMainContentViewController:nil assembly:nil];
}

//-------------------------------------------------------------------------------------------
#pragma mark - Interface Methods
//-------------------------------------------------------------------------------------------

- (void)pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController replaceRoot:NO];
}

- (void)pushViewController:(UIViewController *)viewController replaceRoot:(BOOL)replaceRoot
{
    @synchronized (self)
    {
        if (!_navigator)
        {
            [self makeNavigationControllerWithRoot:viewController];
        }
        else if (replaceRoot)
        {
            [_navigator setViewControllers:@[viewController] animated:YES];
        }
        else
        {
            [_navigator pushViewController:viewController animated:YES];
        }
    }
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    @synchronized (self)
    {
        [_navigator popViewControllerAnimated:animated];
    }
}

- (void)showCitiesListController
{
    if (_sideViewState != PFSideViewStateShowing)
    {
        _sideViewState = PFSideViewStateShowing;

        _citiesListController = [[UINavigationController alloc] initWithRootViewController:[_assembly citiesListController]];

        [_citiesListController.view setFrame:CGRectMake(0, 0,
            _mainContentViewContainer.width - (_mainContentViewContainer.width - SIDE_CONTROLLER_WIDTH), _mainContentViewContainer.height)];

        [self.view setDelegate:self];
        [self.view setLeftFoldContentView:_citiesListController.view foldCount:5 pullFactor:0.9];
        [self.view setPaperFoldState:PaperFoldStateLeftUnfolded];

        [_mainContentViewContainer setNeedsDisplay];
    }
}

- (void)dismissCitiesListController
{
    if (_sideViewState != PFSideViewStateHidden)
    {
        _sideViewState = PFSideViewStateHidden;
        [self.view setPaperFoldState:PaperFoldStateDefault];
        [_navigator.topViewController viewWillAppear:YES];
    }
}

- (void)toggleSideViewController
{
    if (_sideViewState == PFSideViewStateHidden)
    {
        [self showCitiesListController];
    }
    else if (_sideViewState == PFSideViewStateShowing)
    {
        [self dismissCitiesListController];
    }
}


- (void)showAddCitiesController
{
    if (!_addCitiesController)
    {
        [_navigator.topViewController.view setUserInteractionEnabled:NO];
        _addCitiesController = [[UINavigationController alloc] initWithRootViewController:[_assembly addCityViewController]];

        [_addCitiesController.view setFrame:CGRectMake(0, self.view.height, SIDE_CONTROLLER_WIDTH, self.view.height)];
        [self.view addSubview:_addCitiesController.view];

        __block CGRect frame = _citiesListController.view.frame;
        [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            frame.origin.y = 0;
            _addCitiesController.view.frame = frame;
        } completion:nil];
    }
}

- (void)dismissAddCitiesController
{
    if (_addCitiesController)
    {
        [_citiesListController viewWillAppear:YES];
        __block CGRect frame = _citiesListController.view.frame;
        [UIView transitionWithView:self.view duration:0.25 options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            frame.origin.y += self.view.height;
            _addCitiesController.view.frame = frame;
        } completion:^(BOOL finished)
        {
            [_addCitiesController.view removeFromSuperview];
            _addCitiesController = nil;
            [_citiesListController viewDidAppear:YES];
            [_navigator.topViewController.view setUserInteractionEnabled:YES];
        }];
    }
}

//-------------------------------------------------------------------------------------------
#pragma mark - <PaperFoldViewDelegate>
//-------------------------------------------------------------------------------------------

- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    if (paperFoldState == PaperFoldStateDefault)
    {
        [_navigator.topViewController viewDidAppear:YES];

        //We could set the left-side view to nil here, however Paper-fold does not like an empty view at this point
        UIView *dummyView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
        [(PaperFoldView *) self.view setLeftFoldContentView:dummyView foldCount:0 pullFactor:0];
        _citiesListController = nil;
    }
}


//-------------------------------------------------------------------------------------------
#pragma mark - Overridden Methods
//-------------------------------------------------------------------------------------------

- (void)loadView
{
    CGRect screen = [UIScreen mainScreen].bounds;
    self.view = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];

    [self.view setTimerStepDuration:0.02];

    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    _mainContentViewContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    [_mainContentViewContainer setBackgroundColor:[UIColor blackColor]];
    [self.view setCenterContentView:_mainContentViewContainer];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_mainContentViewContainer setFrame:self.view.bounds];
    [_navigator.view setFrame:_mainContentViewContainer.bounds];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate
{
    UIViewController *topController = _navigator.topViewController;
    return [topController shouldAutorotate];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_navigator.topViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_navigator.topViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


//-------------------------------------------------------------------------------------------
#pragma mark - Private Methods
//-------------------------------------------------------------------------------------------

- (void)makeNavigationControllerWithRoot:(UIViewController *)root
{
    _navigator = [[UINavigationController alloc] initWithRootViewController:root];
    _navigator.view.frame = self.view.bounds;
    [_mainContentViewContainer addSubview:_navigator.view];
}


@end
