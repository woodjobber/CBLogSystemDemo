//
//  GNUMLocationMake.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLog.h"

typedef NS_ENUM(NSInteger, GNUMLocationStyle){
    
  GNUMLocationStyleShort,//only name
    
  GNUMLocationStyleLong,//only file ,line,thread
    
};

GNUM_EXTERN GNUMLocation GNUMLocationNotwhere;

GNUM_EXTERN NSString *GNUMStringFromLocation (GNUMLocation location);

GNUM_EXTERN NSString *GNUMStringFromLocationWithStyle(GNUMLocation location, GNUMLocationStyle locationStyle);
GNUM_EXTERN NSString *GNUMLogPrefixFromLocation (GNUMLocation location);

