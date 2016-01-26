//
//  YYHCache.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHCache : NSObject

+ (instancetype)shareInstance;

- (BOOL)containsObjectForKey:(NSString *)key;

- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

#pragma mark - Block
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL bContains))block;

- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;
- (void)removeAllObjectsWithBlock:(void(^)())block;

- (void)cacheSize:(void(^)(NSUInteger size))block;

@end
