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


#import "PFActivityIndicatorTableViewCell.h"


@implementation PFActivityIndicatorTableViewCell

@synthesize loadingLabel = _loadingLabel;
@synthesize spinner = _spinner;


- (void) startAnimating {
    [_spinner setHidden:NO];
    [_spinner startAnimating];
    [_loadingLabel setHidden:NO];
}

- (void) stopAnimating {
    [_spinner setHidden:YES];
    [_spinner stopAnimating];
    [_loadingLabel setHidden:YES];
}


@end