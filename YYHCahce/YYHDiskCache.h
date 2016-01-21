//
//  YYHDiskCache.h
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYHCacheProtocol.h"

@interface YYHDiskCache : NSObject <YYHCacheProtocol>

@property (nonatomic, copy, readonly) NSURL *cacheURL;

- (instancetype)initWithName:(NSString *)name;

@end
