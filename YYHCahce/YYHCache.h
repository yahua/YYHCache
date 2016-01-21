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

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;

@end
