//
//  YYHCache.m
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "YYHCache.h"
#import "YYHMemoryCache.h"
#import "YYHDiskCache.h"

@interface YYHCache ()

@property (nonatomic, strong) YYHMemoryCache *memoryCache;
@property (nonatomic, strong) YYHDiskCache *diskCache;

@end

@implementation YYHCache

+ (instancetype)shareInstance {
    
    static YYHCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYHCache new];
    });
    return cache;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _memoryCache = [YYHMemoryCache new];
        _diskCache = [YYHDiskCache new];
    }
    return self;
}

#pragma mark - Public

- (BOOL)containsObjectForKey:(NSString *)key {
    
    return [_memoryCache containsObjectForKey:key] || [_diskCache containsObjectForKey:key];
}

- (id)objectForKey:(NSString *)key {
    
    id object = [_memoryCache objectForKey:key];
    if (!object) {
        object = [_diskCache objectForKey:key];
        if (object) {
            [_memoryCache setObject:object forKey:key];
        }
    }
    return object;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)removeAllObjects {
    
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

@end
