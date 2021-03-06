//
//  YYHDiskCache.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHDiskCache : NSObject

/**
 *  @author wangsw, 16-01-25 17:01:42
 *
 *  The name of the cache
 */
@property (nonatomic, copy, readonly) NSString *name;

/**
 *  @author wangsw, 16-01-25 16:01:43
 *
 *  缓存文件路径
 */
@property (nonatomic, copy, readonly) NSURL *cacheURL;

/**
 The auto trim check time interval in seconds. Default is 600 (10 minute).
 
 @discussion The cache holds an internal timer to check whether the cache reaches
 its limits, and if the limit is reached, it begins to evict objects.
 */
@property (assign) NSTimeInterval autoTrimInterval;

/**
 缓存文件的最大容量  默认 20M
 */
@property (nonatomic) NSInteger maxCacheCost;

/**
 *  @author wangsw, 16-01-22 19:01:25
 *
 *  Create a new instance with the specified name.
 *
 *  @param name the name of the cache
 *
 *  @return instancetype of YYHDiskCache
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  @author wangsw, 16-01-25 17:01:01
 *
 *  Create a new instance with the specified name.
 *
 *  @param name     the name of the cache
 *  @param rootPath 磁盘缓存路径
 *
 *  @return A new cache object, or nil if an error occurs.
 */
- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath NS_DESIGNATED_INITIALIZER;

//不应该调用以下的两个方法
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;


#pragma mark - 同步方法
- (BOOL)containsObjectForKey:(NSString *)key;

- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

#pragma mark - 异步方法
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL bContains))block;

- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(NSString *key))block;

- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;
- (void)removeAllObjectsWithBlock:(void(^)())block;

- (void)cacheSize:(void(^)(NSUInteger size))block;

@end
