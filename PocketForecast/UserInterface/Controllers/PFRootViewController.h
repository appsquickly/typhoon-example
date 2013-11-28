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


#import <UIKit/UIKit.h>
#import "TyphoonPropertyInjectionDelegate.h"
#import "PaperFoldView.h"


typedef enum
{
    PFSideViewStateHidden,
    PFSideViewStateShowing
} PFSideViewState;

@interface PFRootViewController : UIViewController <TyphoonPropertyInjectionDelegate, PaperFoldViewDelegate>
{
    UINavigationController* _navigator;
    UIView* _mainContentViewContainer;
    UIView* _slideOnMainContentViewContainer;
    PFSideViewState _sideViewState;
    UIViewController* _sideViewController;
}


/**
* Creates a root view controller instance, with the initial main content view controller, and side view controller.
*/
- (instancetype)initWithMainContentViewController:(UIViewController*)mainContentViewController
    sideViewController:(UIViewController*)sideViewController;

/**
* Sets main content view, with an animated transition.
*/
- (void)pushViewController:(UIViewController*)viewController;

- (void)pushViewController:(UIViewController*)viewController replaceRoot:(BOOL)replaceRoot;

- (void)popViewControllerAnimated:(BOOL)animated;

- (void)showSideViewController;

- (void)hideSideViewController;

- (void)toggleSideViewController;


@end
