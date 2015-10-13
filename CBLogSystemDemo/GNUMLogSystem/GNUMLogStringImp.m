//
//  CBLogStringImp.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLogStringImp.h"
#import "GNUMLocationMake.h"
#import "GNUMLogCotroller.h"
static NSDateFormatter *regeneratedLogDateFormatter (void)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    return dateFormatter;
}

//返回对象类型
static NSObject *GNUMNullForZeroLengthString (NSString *string)
{
    return [string length] != 0 ? string : [NSNull null];
}
static NSString *stringWithLogInfo (GNUMLocation location, NSString *logInfo)
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
    //NSString* PhoneName = [[UIDevice currentDevice] model];
   // NSString* version = [[UIDevice currentDevice]systemVersion];
    
   // NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    NSString *body = [[NSArray arrayWithObjects:@".", GNUMNullForZeroLengthString(GNUMLogPrefixFromLocation(location)), logInfo, nil] componentsJoinedByString:@" "];
    NSString *timestamp = [regeneratedLogDateFormatter() stringFromDate:[NSDate date]];
   
    NSString *string = [NSString stringWithFormat:@"%@ <%@>%@", timestamp, app_Name,body];
    
    return string;
    
    
}

void GNUMLogStringToStderr (GNUMLocation loc,NSString *str){
    //GNUMLogCotroller *logController =[[GNUMLogCotroller alloc]init];
    //freopen([logController.logsDirectory cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    //freopen([logController.logsDirectory cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    NSString *logStr = stringWithLogInfo(loc, str);
    
    fprintf(stderr, "%s\n",[logStr UTF8String]);
 
    //fprintf(stdout, "%s\n", [logStr cStringUsingEncoding:NSUTF8StringEncoding]);
  
}
