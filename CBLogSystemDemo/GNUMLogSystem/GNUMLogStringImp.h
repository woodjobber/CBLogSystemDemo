//
//  CBLogStringImp.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import "GNUMLog.h"

@interface GNUMLogStringImp : NSObject

// Use fprintf
GNUM_EXTERN void GNUMLogStringToStderr (GNUMLocation location, NSString *string);

@end
