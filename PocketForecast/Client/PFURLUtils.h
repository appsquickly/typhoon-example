////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2014 Code Monastery Pty Ltd
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of Code Monastery
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////



#import <Foundation/Foundation.h>


@interface PFURLUtils : NSObject

+ (NSURL *)URL:(NSURL *)url appendedWithQueryParameters:(NSDictionary *)parameters;

+ (NSString *)URLEscapeString:(NSString *)rawString;

@end