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

#import "PFThemeProvider.h"
#import "PFThemeFactory.h"
#import "TyphoonDefinition.h"
#import "TyphoonArgumentInjectedAsCollection.h"
#import "TyphoonPropertyInjectedAsCollection.h"
#import "PFTheme.h"
#import "TyphoonInitializer.h"

/**
* This assembly illustrates the use of several concepts: factory-components, collections, and type-converters.
*/
@implementation PFThemeProvider

/**
* Current-theme is emitted from the theme-factory, which increments the theme on each run of the application.
*/
- (id)currentTheme
{
    return [TyphoonDefinition withClass:[PFTheme class] initialization:^(TyphoonInitializer* initializer)
    {
        initializer.selector = @selector(sequentialTheme);
    } properties:^(TyphoonDefinition* definition)
    {
        definition.factory = [self themeFactory];
    }];
}

/**
* The theme factory contains a collection of each theme. Individual themes are using Typhoon's type-converter system to convert the string
* representation of properties to their required runtime type. (This is particularly useful when using PropertyPlaceholder configs).
*/
- (id)themeFactory
{
    return [TyphoonDefinition withClass:[PFThemeFactory class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(themes) asCollection:^(TyphoonPropertyInjectedAsCollection* collection)
        {
            [collection addItemWithDefinition:[self cloudsOverTheCityTheme]];
            [collection addItemWithDefinition:[self beachTheme]];
            [collection addItemWithDefinition:[self lightsInTheRainTheme]];
            [collection addItemWithDefinition:[self sunsetTheme]];
        }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (id)cloudsOverTheCityTheme
{
    return [TyphoonDefinition withClass:[PFTheme class] properties:^(TyphoonDefinition* definition)
    {
    	[definition injectProperty:@selector(backgroundResourceName) withValueAsText:@"bg3.png"];
        [definition injectProperty:@selector(navigationBarColor) withValueAsText:@"#641d23"];
        [definition injectProperty:@selector(forecastTintColor) withValueAsText:@"#641d23"];
        [definition injectProperty:@selector(controlTintColor) withValueAsText:@"#7f9588"];
    }];
}

- (id)lightsInTheRainTheme
{
    return [TyphoonDefinition withClass:[PFTheme class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(backgroundResourceName) withValueAsText:@"bg4.png"];
        [definition injectProperty:@selector(navigationBarColor) withValueAsText:@"#eaa53d"];
        [definition injectProperty:@selector(forecastTintColor) withValueAsText:@"#722d49"];
        [definition injectProperty:@selector(controlTintColor) withValueAsText:@"#722d49"];
    }];
}


- (id)beachTheme
{
    return [TyphoonDefinition withClass:[PFTheme class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(backgroundResourceName) withValueAsText:@"bg5.png"];
        [definition injectProperty:@selector(navigationBarColor) withValueAsText:@"#37b1da"];
        [definition injectProperty:@selector(forecastTintColor) withValueAsText:@"#37b1da"];
        [definition injectProperty:@selector(controlTintColor) withValueAsText:@"#0043a6"];
    }];
}


- (id)sunsetTheme
{
    return [TyphoonDefinition withClass:[PFTheme class] properties:^(TyphoonDefinition* definition)
    {
        [definition injectProperty:@selector(backgroundResourceName) withValueAsText:@"sunset.png"];
        [definition injectProperty:@selector(navigationBarColor) withValueAsText:@"#0a1d3b"];
        [definition injectProperty:@selector(forecastTintColor) withValueAsText:@"#0a1d3b"];
        [definition injectProperty:@selector(controlTintColor) withValueAsText:@"#606970"];
    }];
}


@end