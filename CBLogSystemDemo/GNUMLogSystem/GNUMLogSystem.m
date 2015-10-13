//
//  CBLogSystem.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//
#import "GNUMLogViewController.h"
#import "GNUMLogSystem.h"
#import "GNUMFileOutputHandleProtocol.h"
#import "GNUMLogCotroller.h"
#import "GNUMLogCotroller+Utility.h"
#import "GNUMTeeController.h"
#import "GNUMInstanceFileOutputHandle.h"
#define DEFAULT_EXCEEDING_TOTAL_LOG_SIZE 10*1024*1024

@interface GNUMLogSystem()

@property (nonatomic,strong)GNUMLogCotroller *logController;

@property (nonatomic,strong)id <GNUMFileOutputHandleProtocol> redirectionController;

@end

@implementation GNUMLogSystem

+ (GNUMLogSystem *)defaultLogSystem{
    
    static GNUMLogSystem *logSystem;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logSystem = [[self alloc]init];
    });
    return logSystem;
}
- (id)init{
    if (self =[super init]) {
        self.logController = [[GNUMLogCotroller alloc] init];
    }
    return self;

}
+ (void)setDefaultConfigure{
    
    [self setLogConfigureWithExeedingTotalLogSize:DEFAULT_EXCEEDING_TOTAL_LOG_SIZE];
    
}
+ (void)setLogConfigureWithExeedingTotalLogSize:(unsigned long long)toalLogSize
{
    GNUMLogSystem *logConfigure = [GNUMLogSystem defaultLogSystem];
    
    [logConfigure.logController removeOldLogsExceedingTotalSize:toalLogSize];
    
    if (!logConfigure.redirectionController) {
        if ([GNUMLogCotroller forceConsoleLog]) {
            logConfigure.redirectionController = [[GNUMTeeController alloc] init];
        } else {
            logConfigure.redirectionController = [[GNUMInstanceFileOutputHandle alloc] init];
        }
        [logConfigure.logController startCapturingLogsWithRedirectionController:logConfigure.redirectionController];
        [logConfigure.redirectionController beginRecordLog];
    }

}
+ (NSArray *)availableLogs{

    
    if ([GNUMLogSystem  defaultLogSystem].logController) {
        
        return [GNUMLogSystem defaultLogSystem].logController.availableLogs;
    } else {
        return nil;
    }
}

+ (void)activeShowLogInfo
{
    GNUMLogViewController *logViewController = [[GNUMLogViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:logViewController];
    
    UIApplication *application = [UIApplication sharedApplication];
    [application.windows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKeyWindow]) {
            UIWindow *keyWindow = obj;
            if (keyWindow.rootViewController) {
                [keyWindow.rootViewController presentViewController:navigationController animated:YES completion:NULL];
            }
        }
    }];
}

@end
