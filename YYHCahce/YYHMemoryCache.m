//
//  YYHMemoryCache.m
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "YYHMemoryCache.h"
#import <pthread.h>

@interface YYHMemoryCache ()

@property (nonatomic, strong) NSMutableArray *cacheKeyList;
@property (nonatomic, strong) NSMutableDictionary *cacheObjectDic;

@property (nonatomic, assign) pthread_mutex_t lock;

@end

@implementation YYHMemoryCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacheKeyList = [NSMutableArray arrayWithCapacity:1];
        _cacheObjectDic = [NSMutableDictionary dictionaryWithCapacity:1];
        
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

#pragma mark - YYHCacheProtocol

- (BOOL)containsObjectForKey:(NSString *)key {
    
    return ([_cacheObjectDic objectForKey:key] != nil);
}

- (id)objectForKey:(NSString *)key {
    
    return [_cacheObjectDic objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    
    if (!key) {
        return;
    }
    pthread_mutex_lock(&_lock);
    
    if (!object) {
        [_cacheKeyList removeObject:key];
        [_cacheObjectDic removeObjectForKey:key];
        return;
    }
    
    if ([_cacheObjectDic objectForKey:key] == object) {
        return;
    }
    
    [_cacheKeyList addObject:key];
    [_cacheObjectDic setObject:object forKey:key];
    
    pthread_mutex_unlock(&_lock);
}

- (void)removeObjectForKey:(NSString *)key {
    
    pthread_mutex_lock(&_lock);
    
    if ([_cacheKeyList containsObject:key]) {
        [_cacheKeyList removeObject:key];
        [_cacheObjectDic removeObjectForKey:key];
    }
    
    pthread_mutex_unlock(&_lock);
}

- (void)removeAllObjects {
    
    pthread_mutex_lock(&_lock);
    [_cacheKeyList removeAllObjects];
    [_cacheObjectDic removeAllObjects];
    pthread_mutex_unlock(&_lock);
}

@end
