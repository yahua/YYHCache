//
//  YYHDiskCache.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHDiskCache : NSObject 

@property (nonatomic, copy, readonly) NSURL *cacheURL;

/**
 The auto trim check time interval in seconds. Default is 600 (10 minute).
 
 @discussion The cache holds an internal timer to check whether the cache reaches
 its limits, and if the limit is reached, it begins to evict objects.
 */
@property (assign) NSTimeInterval autoTrimInterval;

/**
 *  @author wangsw, 16-01-22 19:01:25
 *
 *  初始化必须调用该方法
 *
 *  @param name 缓存的文件夹名
 *
 *  @return instancetype of YYHDiskCache
 */
- (instancetype)initWithName:(NSString *)name;

#pragma mark - not Block
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
