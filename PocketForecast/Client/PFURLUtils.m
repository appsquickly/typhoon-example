////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2014 Code Monastery Pty Ltd
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of Code Monastery
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////



#import "PFURLUtils.h"


@implementation PFURLUtils

+ (NSURL *)URL:(NSURL *)url appendedWithQueryParameters:(NSDictionary *)parameters
{
    NSMutableString *urlString = [[NSMutableString alloc] initWithString:[url absoluteString]];

    for (id key in parameters) {
        NSString *keyString = [key description];
        NSString *valueString = [[parameters objectForKey:key] description];

        if ([urlString rangeOfString:@"?"].location == NSNotFound) {
            [urlString appendFormat:@"?%@=%@", [self URLEscapeString:keyString], [self URLEscapeString:valueString]];
        }
        else {
            [urlString appendFormat:@"&%@=%@", [self URLEscapeString:keyString], [self URLEscapeString:valueString]];
        }
    }
    return [NSURL URLWithString:urlString];
}

+ (NSString *)URLEscapeString:(NSString *)rawString
{
    CFStringRef originalStringRef = (__bridge_retained CFStringRef) rawString;
    NSString *encoded =
        (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, originalStringRef, NULL, NULL, kCFStringEncodingUTF8);
    CFRelease(originalStringRef);
    return encoded;
}

@end