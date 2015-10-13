//
//  CBLogCotroller+Utility.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLogCotroller.h"

@interface GNUMLogCotroller (Utility)

- (NSString *)pathForbasename:(NSString *)basename;

+ (NSString *)basenamePrefix;

+ (NSString *)pathExtension;

+ (BOOL)forceConsoleLog;

+ (NSString *)basenameForDate:(NSDate *)date;


@end
