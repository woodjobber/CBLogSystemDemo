//
//  CBLog.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.

#import "GNUMLog.h"
#import "GNUMLogStringImp.h"

enum GNUMLogKind{
    
    GNUMKindStdErr,
    
};
enum GNUMLogKind GNUMLogBaseKind = GNUMKindStdErr;


static void GNUMLogString (GNUMLocation loc,NSString *str){
    
    if (GNUMKindStdErr == GNUMLogBaseKind) {
        GNUMLogStringToStderr(loc, str);
    }

}
void GNUMLog (GNUMLocation location, NSString *format, ...){

    NSString *str;
    {
        va_list ap;
        va_start(ap, format);
        str = [[NSString alloc] initWithFormat:format arguments:ap];
        va_end(ap);
    }
    
    GNUMLogString(location, str);
}


void switchToStderr (void)
{
    GNUMLogBaseKind = GNUMKindStdErr;
}

