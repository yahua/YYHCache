//
//  YYHMemoryCache.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYHMemoryCache : NSObject

//UIApplicationDidReceiveMemoryWarningNotification 是否要清楚内存缓存, 默认为YES
@property (nonatomic, assign) BOOL clearWhenMemoryLow;

- (BOOL)containsObjectForKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

@end
