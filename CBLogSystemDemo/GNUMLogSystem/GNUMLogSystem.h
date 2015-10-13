//
//  CBLogSystem.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNUMLog.h"
#define FILENAME @"GUNMLogSystem"
#define NSLog(...) CBLog(__VA_ARGS__)
#define CBLog(FORMAT,...)\
GNUMLog(GNUM_LOCATION(),FORMAT,##__VA_ARGS__)

@interface GNUMLogSystem : NSObject

+ (void)setDefaultConfigure;

+ (void)setLogConfigureWithExeedingTotalLogSize:(unsigned long long)toalLogSize;

+ (NSArray *)availableLogs;

+ (void)activeShowLogInfo;
@end
