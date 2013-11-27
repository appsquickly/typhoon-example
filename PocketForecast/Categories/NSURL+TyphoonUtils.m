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


#import "NSURL+TyphoonUtils.h"


@implementation NSURL (TyphoonUtils)

- (NSString*)urlEscapeString:(NSString*)rawString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef) rawString;
    NSString* encoded =
        (__bridge_transfer NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, originalStringRef, NULL, NULL, kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return encoded;
}


- (NSURL*)URLByAppendingQueryParameters:(NSDictionary*)parameters
{
    NSMutableString* urlString = [[NSMutableString alloc] initWithString:[self absoluteString]];

    for (id key in parameters)
    {
        NSString* keyString = [key description];
        NSString* valueString = [[parameters objectForKey:key] description];

        if ([urlString rangeOfString:@"?"].location == NSNotFound)
        {
            [urlString appendFormat:@"?%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
        else
        {
            [urlString appendFormat:@"&%@=%@", [self urlEscapeString:keyString], [self urlEscapeString:valueString]];
        }
    }
    return [NSURL URLWithString:urlString];
}

@end