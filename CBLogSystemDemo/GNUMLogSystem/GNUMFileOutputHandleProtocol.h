//
//  CBFileOutputHandle.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GNUMFileOutputHandleProtocol <NSObject>

@property (nonatomic,strong)NSFileHandle *inputFileHandle;

@property (nonatomic,strong)NSFileHandle *outputFileHandle;


- (void)beginRecordLog;

- (void)stopRecordLog;

@end
