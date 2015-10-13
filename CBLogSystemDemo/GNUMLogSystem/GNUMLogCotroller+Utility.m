
//
//  CBLogCotroller+Utility.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLogCotroller+Utility.h"

@implementation GNUMLogCotroller (Utility)
- (NSString *)pathForbasename:(NSString *)basename
{
    NSString *fileName = [basename stringByAppendingPathExtension:[GNUMLogCotroller pathExtension]];
    return [self.logsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSString *)basenameForDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSString *basenamePrefix = [self basenamePrefix];
    NSString *basename = [basenamePrefix stringByAppendingString:dateString];
    return basename;
}

+ (BOOL)forceConsoleLog
{
    //获取环境变量
    //NSDictionary *ervironmentDic = [NSProcessInfo processInfo].environment;
   // NSLog(@"%@",ervironmentDic );
    
    return [[[NSProcessInfo processInfo].environment objectForKey:@"NSUnbufferedIO"] boolValue];
}

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd-HH:mm:ss";
    return dateFormatter;
}

+ (NSString *)basenamePrefix
{
    NSString *processName = [NSProcessInfo processInfo].processName;
    NSString *basenamePrefix = [NSString stringWithFormat:@"%@_", processName];
    return basenamePrefix;
}

+ (NSString *)pathExtension
{
    return @"log";
}

+ (NSString *)separator;
{
    return @"_";
}
@end
