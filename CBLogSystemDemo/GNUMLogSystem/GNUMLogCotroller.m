//
//  CBLogCotroller.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLogCotroller.h"
#import <signal.h>
#import <unistd.h>
#import <asl.h>
#import <UIKit/UIKit.h>
#import "GNUMLogCotroller+Utility.h"
#import "NSObject+GNUMReverseComparison.h"
#import "GNUMLog.h"

@interface GNUMLogCotroller()

@property (nonatomic, strong) NSString *logsDirectory;

@property (nonatomic, strong) NSArray *availableLogs;

@property (nonatomic, strong) NSString *outputBasename;


@end


@implementation GNUMLogCotroller

- (id)init
{
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.logsDirectory = [paths[0] stringByAppendingPathComponent:FILENAME];
    }
    

    
    return self;
}
- (NSArray *)availableLogs
{
    NSArray *availableLogs;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:self.logsDirectory error:&error];
    if (!contents) {
        availableLogs = nil;
    } else {
        NSString *dotAndPathExtension = [[@"a" stringByAppendingString:[GNUMLogCotroller pathExtension]] substringFromIndex:1];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(self endswith %@) and (self beginswith %@)", dotAndPathExtension, [GNUMLogCotroller basenamePrefix]];
        NSArray *filteredContents = [contents filteredArrayUsingPredicate:predicate];
        NSMutableArray *filteredPaths = [NSMutableArray array];
        
        for (NSString *filename in filteredContents) {
            NSString *path = [self.logsDirectory stringByAppendingPathComponent:filename];
            [filteredPaths addObject:path];
        }
        
        availableLogs = [filteredPaths sortedArrayUsingSelector:@selector(reverseComparion:)];
    }
    
    return availableLogs;
}
- (void)startCapturingLogsWithRedirectionController: (id <GNUMFileOutputHandleProtocol>)fileOutputRedirectionController
{
   
    switchToStderr();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *outputBasename = [GNUMLogCotroller basenameForDate:[NSDate date]];
    NSString *outputFilePath = [self pathForbasename:outputBasename];
    
    if (![fileManager fileExistsAtPath:self.logsDirectory]) {
        NSError *error;
        [fileManager createDirectoryAtPath:self.logsDirectory withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    BOOL fileAlreadyExists = [fileManager fileExistsAtPath:outputFilePath];
    
    if (!fileAlreadyExists) {
        NSData *data = [NSData data];
        [fileManager createFileAtPath:outputFilePath contents:data attributes:nil];
    }
    
    
    
    NSFileHandle *outputFileHandle = [NSFileHandle fileHandleForWritingAtPath:outputFilePath];
    [outputFileHandle seekToEndOfFile];
    
    NSFileHandle *inputFileHandle = [NSFileHandle fileHandleWithStandardError];
    
    fileOutputRedirectionController.outputFileHandle = outputFileHandle;
    fileOutputRedirectionController.inputFileHandle = inputFileHandle;
    self.fileOutputRedirectionController = fileOutputRedirectionController;
    // 获取文件路径中的最后组件， 并去掉扩展名
    self.outputBasename = [[outputFilePath lastPathComponent] stringByDeletingPathExtension];
    
}

- (void)removeOldLogsExceedingTotalSize: (unsigned long long)maximumTotalSize 
{
    NSArray *availableLogs = [self availableLogs];
    
    if (availableLogs && availableLogs.count > 0) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        unsigned long long totalSize = 0ULL;
        
        NSUInteger index;
        
        for (index = 0; index < availableLogs.count; index ++) {
            NSString *path = [availableLogs objectAtIndex:index];
            NSError *error = nil;
            NSDictionary *attributesDic = [fileManager attributesOfItemAtPath:path error:&error];
            
            if (attributesDic) {
                unsigned long long fileSize = [[attributesDic valueForKey:@"NSFileSize"] longLongValue];
                unsigned long long updatedTotalSize = fileSize + totalSize;
                if (updatedTotalSize > maximumTotalSize) {
                    if (index < SAVEMINMUNCOUNT) {
                        index = MIN(SAVEMINMUNCOUNT, availableLogs.count);
                    }
                    break;
                } else {
                    totalSize = updatedTotalSize;
                }
            }
        }
        
        NSArray *logsForRemoval = [availableLogs subarrayWithRange:NSMakeRange(index, availableLogs.count - index)];
        
        for (NSString *pathForRemoval in logsForRemoval) {
             NSError *error = nil;
            [fileManager removeItemAtPath:pathForRemoval error:&error];
            if (error) {
                CBLog(@"remove Item happen to error!");
            }
        }
    }
}
- (void)flush
{
    fflush (stderr);
    fflush (stdout);
    
    [self.fileOutputRedirectionController stopRecordLog];
}

@end
