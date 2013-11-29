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

#import "PFThemeFactory.h"
#import "PFTheme.h"

static NSString* const kCurrentThemeIndexFileName = @"PF_CURRENT_THEME_INDEX";

@interface PFThemeFactory ()

@property(nonatomic, strong, readwrite) NSArray* themes;

@end

@implementation PFThemeFactory


- (PFTheme*)sequentialTheme
{
    if ([_themes count] == 0)
    {
        [NSException raise:NSInvalidArgumentException format:@"Sequential theme requires at least one theme in collection"];
    }

    if (!_sequentialTheme)
    {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString* indexFileName = [documentsDirectory stringByAppendingPathComponent:kCurrentThemeIndexFileName];
        LogDebug(@"Index file name: %@", indexFileName);


        NSInteger index = [[NSString stringWithContentsOfFile:indexFileName encoding:NSUTF8StringEncoding error:nil] integerValue];
        LogDebug(@"Current theme index is: %i", index);
        if (index > [_themes count] - 1)
        {
            LogDebug(@"$$$$$$$$$$$$$ resetting index");
            index = 0;
        }
        _sequentialTheme = [_themes objectAtIndex:index];
        [[NSString stringWithFormat:@"%i", (index + 1)] writeToFile:indexFileName atomically:NO encoding:NSUTF8StringEncoding error:nil];

    }
    return _sequentialTheme;
}


@end