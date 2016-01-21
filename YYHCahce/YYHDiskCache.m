//
//  YYHDiskCache.m
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "YYHDiskCache.h"

#define YYHDiskCachePrefix @"YYHCache"

@interface YYHDiskCache ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation YYHDiskCache

- (instancetype)init {
    
    NSAssert(0, @"应该调用initWithName:");
    return nil;
}

- (instancetype)initWithName:(NSString *)name {
    
    if (!name) {
        name = @"";
    }
    if (self = [super init]) {
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *pathComponent = [[NSString alloc] initWithFormat:@"%@.%@", YYHDiskCachePrefix, name];
        _cacheURL = [NSURL fileURLWithPathComponents:@[rootPath, pathComponent]];
        _fileManager = [NSFileManager new];
        
        if (![_fileManager fileExistsAtPath:_cacheURL.absoluteString]) {
            [_fileManager createDirectoryAtPath:_cacheURL.absoluteString
                    withIntermediateDirectories:YES
                                     attributes:nil
                                          error:NULL];
        }
        
    }
    
    return self;
}

#pragma mark - YYHCacheProtocol

- (BOOL)containsObjectForKey:(NSString *)key {
    
    return [_fileManager fileExistsAtPath:[self p_fileNameWithKey:key].absoluteString];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    
    NSData *data = [NSData dataWithContentsOfURL:[self p_fileNameWithKey:key]];
    if (!data) return nil;
    id object;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *exception) {
        NSAssert(0, @"不是NSCoding");
    }
    return object;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    
    if (!object) {
        [self removeObjectForKey:key];
    }
    else
    {
        NSData *value;
        @try {
            value = [NSKeyedArchiver archivedDataWithRootObject:object];
        }
        @catch (NSException *exception) {
            NSAssert(0, @"不是NSCoding");
        }
        if (!value)  return;
        
        [value writeToURL:[self p_fileNameWithKey:key] atomically:NO];
        
    }
}

- (void)removeObjectForKey:(NSString *)key {
    
    NSError *error= nil;
    [_fileManager removeItemAtURL:[self p_fileNameWithKey:key] error:&error];
    if (error) {
        NSAssert(0, @"文件移除失败");
    }
}

- (void)removeAllObjects {
    
    NSError *error = nil;
    [_fileManager removeItemAtURL:_cacheURL error:&error];
    if (error) {
        NSAssert(0, @"文件移除失败");
    }
}

#pragma mark - Private

- (NSURL *)p_fileNameWithKey:(NSString *)key {
    
    return [_cacheURL URLByAppendingPathComponent:key];
}

@end
