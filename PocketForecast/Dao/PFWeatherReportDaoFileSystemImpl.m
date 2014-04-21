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



#import "PFWeatherReport.h"
#import "PFWeatherReportDaoFileSystemImpl.h"


@implementation PFWeatherReportDaoFileSystemImpl


- (PFWeatherReport*) getReportForCityName:(NSString*)cityName {
    NSString* filePath = [self filePathFor:cityName];

    PFWeatherReport* weatherReport = (PFWeatherReport*) [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return weatherReport;

}

- (void) saveReport:(PFWeatherReport*)weatherReport {
    LogDebug(@"Saving weather report: %@", weatherReport);
    [NSKeyedArchiver archiveRootObject:weatherReport toFile:[self filePathFor:[weatherReport cityDisplayName]]];
}


/* ====================================================================================================================================== */
#pragma mark - Private Methods

- (NSString*) filePathFor:(NSString*)cityName {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* weatherReportKey = [NSString stringWithFormat:@"weatherReport$$%@", cityName];
    NSString* filePath = [documentsDirectory stringByAppendingPathComponent:weatherReportKey];
    LogDebug(@"Filepath for archiving: %@", filePath);
    return filePath;
}


@end