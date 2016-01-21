//
//  YYHCacheProtocol.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#ifndef YYHCacheProtocol_h
#define YYHCacheProtocol_h

@protocol YYHCacheProtocol <NSObject>

- (BOOL)containsObjectForKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;
- (void)removeAllObjects;

@optional

@end

#endif /* YYHCacheProtocol_h */
