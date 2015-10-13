//
//  GNUMLocationMake.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLocationMake.h"

static NSString *GNUMStringWithSourceLocationFromLocation(GNUMLocation location);
static NSString *GNUMStringFromSourceFilePath(const char *file);

GNUMLocation GNUMLocationNotwhere = {
    
    GNUM_INITIALIZED_FIELD(file, ""),
    GNUM_INITIALIZED_FIELD(line, 0),
    GNUM_INITIALIZED_FIELD(func, "")
};

NSString *GNUMStringFromLocation(GNUMLocation location)
{
    return GNUMStringFromLocationWithStyle(location, GNUMLocationStyleLong);
}

NSString *GNUMStringFromLocationWithStyle(GNUMLocation location, GNUMLocationStyle locationStyle)
{
    NSString *string;
    switch (locationStyle) {
        case GNUMLocationStyleLong:
        {
            NSString *sourceLocationDescription = GNUMStringWithSourceLocationFromLocation(location);
            NSArray *stringArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", [NSThread currentThread].description], (sourceLocationDescription.length > 0 ? [NSString stringWithFormat:@"%@", sourceLocationDescription] : [NSNull null]), nil];
            string = [stringArray componentsJoinedByString:@" "];
        }
            break;
        case GNUMLocationStyleShort:
            string = [NSString stringWithFormat:@"%s", location.func];
            break;
        default:
            abort();
            break;
    }
    return string;
}

NSString *GNUMLogPrefixFromLocation (GNUMLocation location)
{
    NSString *sourceLocationDescription = GNUMStringWithSourceLocationFromLocation(location);
    //NSLog(@"%@",[NSString stringWithFormat:@"%@", [NSThread currentThread].description]);
    NSArray *stringArray = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@", [NSThread currentThread].description], (sourceLocationDescription.length > 0 ? [NSString stringWithFormat:@"%@:", sourceLocationDescription] : [NSNull null]), nil];
    NSString *string = [stringArray componentsJoinedByString:@" "];
    return string;
}

#pragma mark -- private
//文件路径
static NSString *GNUMStringFromSourceFilePath(const char *file)
{
    NSString *path = [[NSFileManager defaultManager] stringWithFileSystemRepresentation:file length:strlen(file)];
    NSString *string = [path lastPathComponent];
    return string;
}

//从源文件路径拼接 line func
static NSString *GNUMStringWithSourceLocationFromLocation(GNUMLocation location)
{
    NSString *string = nil;
    if (!memcmp(&location, &GNUMLocationNotwhere, sizeof(location))) {
        string = @"";
    } else {
        string = [NSString stringWithFormat:@"<%@> At <%d> (%s)", GNUMStringFromSourceFilePath(location.file), location.line, location.func];
        
    }
    return string;
}
