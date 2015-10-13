//
//  CBInstanceFileOutputHandle.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMInstanceFileOutputHandle.h"
@interface GNUMInstanceFileOutputHandle()

@property (nonatomic,strong)NSFileHandle *handleDup;


@end

@implementation GNUMInstanceFileOutputHandle
@synthesize inputFileHandle;
@synthesize outputFileHandle;

- (void)beginRecordLog{
    
    int inputFileDescriptorDup = dup(self.inputFileHandle.fileDescriptor);
    dup2(self.outputFileHandle.fileDescriptor, self.inputFileHandle.fileDescriptor);
    self.inputFileHandle = [[NSFileHandle alloc]initWithFileDescriptor:inputFileDescriptorDup];

}

- (void)stopRecordLog{
    
    dup2(self.inputFileHandle.fileDescriptor, self.outputFileHandle.fileDescriptor);
    self.inputFileHandle = nil;
}

@end
