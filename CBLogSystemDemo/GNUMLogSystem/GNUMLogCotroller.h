//
//  CBLogCotroller.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNUMFileOutputHandleProtocol.h"
#import "GNUMLogSystem.h"

#define SAVEMINMUNCOUNT 20

@interface GNUMLogCotroller : NSObject

@property (nonatomic,weak)id<GNUMFileOutputHandleProtocol>fileOutputRedirectionController;
@property (nonatomic,strong,readonly) NSString *logsDirectory;
@property (nonatomic,strong,readonly) NSArray *availableLogs;

- (void)startCapturingLogsWithRedirectionController: (id <GNUMFileOutputHandleProtocol>)fileOutputRedirectionController;



- (void)removeOldLogsExceedingTotalSize: (unsigned long long)maximumTotalSize;
@end
