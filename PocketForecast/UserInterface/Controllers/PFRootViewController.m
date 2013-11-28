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


#import "CKUITools.h"
#import "PFRootViewController.h"
#import "PaperFoldView.h"

#define SIDE_CONTROLLER_WIDTH 245.0

@implementation PFRootViewController

/* ====================================================================================================================================== */
#pragma mark - Initialization & Destruction

- (instancetype)initWithMainContentViewController:(UIViewController*)mainContentViewController
    sideViewController:(UIViewController*)sideViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _sideViewState = PFSideViewStateHidden;
        _sideViewController = sideViewController;
        if (mainContentViewController)
        {
            [self pushViewController:mainContentViewController replaceRoot:YES];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithMainContentViewController:nil sideViewController:nil];
}

- (void)beforePropertiesSet
{
    if (self.view)
    {} //Eager load view
}

- (void)afterPropertiesSet
{

}

/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)pushViewController:(UIViewController*)viewController
{
    [self pushViewController:viewController replaceRoot:NO];
}

- (void)pushViewController:(UIViewController*)viewController replaceRoot:(BOOL)replaceRoot
{
    @synchronized (self)
    {
        if (replaceRoot || _navigator == nil)
        {
            BOOL isApplicationStartup = _navigator == nil ? YES : NO;

            [self makeNavigationControllerWithRoot:viewController];
            if (!isApplicationStartup)
            {
                [self performPushAnimation];
            }
            else
            {
                [_navigator.view setFrame:_mainContentViewContainer.bounds];
                [_mainContentViewContainer addSubview:_navigator.view];
            }
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

- (void)showSideViewController
{
    if (_sideViewState != PFSideViewStateShowing)
    {
        _sideViewState = PFSideViewStateShowing;

        [_sideViewController.view setFrame:CGRectMake(0, 0,
            _mainContentViewContainer.width - (_mainContentViewContainer.width - SIDE_CONTROLLER_WIDTH), _mainContentViewContainer.height)];

        PaperFoldView* view = (PaperFoldView*) self.view;
        [view setDelegate:self];
        [view setLeftFoldContentView:_sideViewController.view foldCount:5 pullFactor:0.9];
        [view setEnableLeftFoldDragging:NO];
        [view setEnableRightFoldDragging:NO];
        [view setEnableTopFoldDragging:NO];
        [view setEnableBottomFoldDragging:NO];
        [view setEnableHorizontalEdgeDragging:NO];
        [view setPaperFoldState:PaperFoldStateLeftUnfolded];

        [_mainContentViewContainer setNeedsDisplay];
    }
}

- (void)hideSideViewController
{
    if (_sideViewState != PFSideViewStateHidden)
    {
        _sideViewState = PFSideViewStateHidden;
        PaperFoldView* view = (PaperFoldView*) self.view;
        [view setPaperFoldState:PaperFoldStateDefault];
        [_navigator.topViewController viewWillAppear:YES];
    }
}

- (void)toggleSideViewController
{
    if (_sideViewState == PFSideViewStateHidden)
    {
        [self showSideViewController];
    }
    else if (_sideViewState == PFSideViewStateShowing)
    {
        [self hideSideViewController];
    }
}


/* ====================================================================================================================================== */
#pragma mark - Override

- (void)loadView
{
    CGRect screen = [UIScreen mainScreen].bounds;

    PaperFoldView* paperFoldView;

    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7)
    {
        paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    }
    else
    {
        paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width,
            screen.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
    }
    [paperFoldView setTimerStepDuration:0.02];
    self.view = paperFoldView;

    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];

    _mainContentViewContainer = [[UIView alloc] initWithFrame:self.view.bounds];
    [_mainContentViewContainer setBackgroundColor:[UIColor blackColor]];
    [paperFoldView setCenterContentView:_mainContentViewContainer];

    _slideOnMainContentViewContainer = [[UIView alloc] initWithFrame:_mainContentViewContainer.bounds];
    [_slideOnMainContentViewContainer setHidden:YES];
    [self.view addSubview:_slideOnMainContentViewContainer];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_mainContentViewContainer setFrame:self.view.bounds];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    UIViewController* topController = _navigator.topViewController;
    return [topController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (BOOL)shouldAutorotate
{
    UIViewController* topController = _navigator.topViewController;
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

/* ====================================================================================================================================== */
#pragma mark - Protocol Methods

- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    if (paperFoldState == PaperFoldStateDefault)
    {
        [_navigator.topViewController viewDidAppear:YES];
    }
}


/* ============================================================ Private Methods ========================================================= */
- (void)makeNavigationControllerWithRoot:(UIViewController*)root
{
    _navigator = [[UINavigationController alloc] initWithRootViewController:root];
    _navigator.view.frame = self.view.bounds;
}

- (void)performPushAnimation
{
    CGFloat slideOnInitialX = _mainContentViewContainer.frame.size.width;
    _slideOnMainContentViewContainer.frame =
        CGRectMake(slideOnInitialX, 0, _mainContentViewContainer.frame.size.width, _mainContentViewContainer.frame.size.height);
    _mainContentViewContainer.frame =
        CGRectMake(0, 0, _mainContentViewContainer.frame.size.width, _mainContentViewContainer.frame.size.height);
    [_slideOnMainContentViewContainer addSubview:_navigator.view];
    [_slideOnMainContentViewContainer setHidden:NO];

    CGRect mainContentViewFrame = _mainContentViewContainer.frame;
    mainContentViewFrame.origin.x -= slideOnInitialX;
    CGRect slideOnViewFrame = _slideOnMainContentViewContainer.frame;
    slideOnViewFrame.origin.x -= slideOnInitialX;

    [UIView transitionWithView:_mainContentViewContainer duration:0.40 options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
        _mainContentViewContainer.frame = mainContentViewFrame;
        _slideOnMainContentViewContainer.frame = slideOnViewFrame;
    } completion:^(BOOL complete)
    {
        [_navigator.view removeFromSuperview];
        [_navigator.view setFrame:_mainContentViewContainer.bounds];
        [_mainContentViewContainer addSubview:_navigator.view];
        [_mainContentViewContainer setFrame:self.view.bounds];
        [_slideOnMainContentViewContainer setHidden:YES];
    }];
}

@end
