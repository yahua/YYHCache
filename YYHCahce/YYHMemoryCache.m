//
//  YYHMemoryCache.m
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "YYHMemoryCache.h"
#import <UIKit/UIKit.h>

#define DEFAULT_MAX_COUNT (48)

@interface YYHMemoryCache ()

@property (nonatomic, assign) NSInteger maxCacheCount;
@property (nonatomic, strong) NSMutableArray *cacheKeyList;
@property (nonatomic, strong) NSMutableDictionary *cacheObjectDic;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation YYHMemoryCache

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clearWhenMemoryLow = YES;
        _maxCacheCount = DEFAULT_MAX_COUNT;
        _cacheKeyList = [NSMutableArray arrayWithCapacity:1];
        _cacheObjectDic = [NSMutableDictionary dictionaryWithCapacity:1];
        
        _lock = [NSLock new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - NSNotification

- (void)didReceiveMemoryWarningNotification {
    
    if (_clearWhenMemoryLow) {
        [self removeAllObjects];
    }
}

#pragma mark - Public

- (BOOL)containsObjectForKey:(NSString *)key {
    
    BOOL bContains = NO;
    [_lock lock];
    bContains = ([_cacheObjectDic objectForKey:key] != nil);
    [_lock unlock];
    
    return bContains;
}

- (id)objectForKey:(NSString *)key {
    
    id object = nil;
    [_lock lock];
    object = [_cacheObjectDic objectForKey:key];
    [_lock unlock];
    
    return object;
}

- (void)setObject:(id)object forKey:(NSString *)key {
    
    if (!key) {
        return;
    }
    
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    
    [_lock lock];
    
    if ([_cacheObjectDic objectForKey:key] == object) {
        [_lock unlock];
        return;
    }
    
    [_cacheKeyList addObject:key];
    if (_cacheKeyList.count>_maxCacheCount) {
        NSString *removeKey = [_cacheKeyList firstObject];
        [_cacheKeyList removeObjectAtIndex:0];
        [_cacheObjectDic removeObjectForKey:removeKey];
    }
    [_cacheObjectDic setObject:object forKey:key];
    
    [_lock unlock];
}

- (void)removeObjectForKey:(NSString *)key {
    
    [_lock lock];
    
    if ([_cacheKeyList containsObject:key]) {
        [_cacheKeyList removeObject:key];
        [_cacheObjectDic removeObjectForKey:key];
    }
    
    [_lock unlock];
}

- (void)removeAllObjects {
    
    [_lock lock];
    
    [_cacheKeyList removeAllObjects];
    [_cacheObjectDic removeAllObjects];
    
    [_lock unlock];
}

@end
