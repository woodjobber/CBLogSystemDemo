//
//  NSObject+CBReverseComparison.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "NSObject+GNUMReverseComparison.h"
@interface NSObject ()
- (NSComparisonResult)compare:(id)object;
@end
@implementation NSObject (GNUMReverseComparison)
- (NSComparisonResult)reverseComparion:(id)anObject{

    NSComparisonResult same_comparisonResult = NSOrderedSame;
    if ([self respondsToSelector:@selector(compare:)]) {
        same_comparisonResult = [self compare:anObject];
        NSComparisonResult comparisonResult = (NSOrderedAscending == same_comparisonResult)
        ? (NSComparisonResult) NSOrderedDescending
        : ((NSOrderedDescending == same_comparisonResult)
           ? (NSComparisonResult) NSOrderedAscending
           : same_comparisonResult);
        
        return comparisonResult;
    }else{
        NSLog(@"%@ -> The object do not implement \"comparison\" function.",self);
        return same_comparisonResult;
    }
}
@end
