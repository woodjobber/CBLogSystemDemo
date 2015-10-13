//
//  CBLog.h
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-15.
//  Copyright (c) 2015年 zcb. All rights reserved.
//

#import <Foundation/Foundation.h>


#define GNUM_ERR_LOG       1
#define GNUM_WARN_LOG      2
#define GNUM_INFO_LOG      3
#define GNUM_DEBUG_LOG     4

#ifdef __cplusplus
#define GNUM_EXTERN  extern "C" __attribute__((visibility ("default")))
#else
#define GNUM_EXTERN  extern __attribute__((visibility ("default")))
#endif

#ifdef __cplusplus
# if !defined __clang__
#  define GNUM_INITIALIZED_FIELD(name, ...) \
name: __VA_ARGS__
# else
#  define GNUM_INITIALIZED_FIELD(name, ...) \
.name = __VA_ARGS__
# endif
#else
# define GNUM_INITIALIZED_FIELD(name, ...) \
.name = __VA_ARGS__
#endif
// Location
typedef struct {
    char const *file;
    int line;
    char const *func;
} GNUMLocation;

static inline GNUMLocation GNUMLocationMake (char const *file, int line, char const *func)
{
    GNUMLocation location;
    location.file = file;
    location.line = line;
    location.func = func;
    
    return location;
}

#define GNUM_LOCATION() \
GNUMLocationMake (__FILE__, __LINE__, __FUNCTION__)
//  Log
GNUM_EXTERN void GNUMLog(GNUMLocation location,NSString *foramt,...);

GNUM_EXTERN void switchToStderr (void);

