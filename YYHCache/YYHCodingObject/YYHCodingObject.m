//
//  YYHCodingObject.m
//  YYHCacheDemo
//
//  Created by wangsw on 16/1/25.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "YYHCodingObject.h"
#import <objc/runtime.h>

static void *YHModelCachedPropertyKeysKey = &YHModelCachedPropertyKeysKey;

@implementation YYHCodingObject

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        NSArray *propertyNames = [[self class] p_propertyKeys].allObjects;
        for (NSString *propertyName in propertyNames) {
            [self setValue:[coder decodeObjectForKey:propertyName] forKey:propertyName];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    NSArray *propertyNames = [[self class] p_propertyKeys].allObjects;
    for (NSString *propertyName in propertyNames) {
        id propertyValue = [self valueForKey:propertyName];
        [aCoder encodeObject:propertyValue forKey:propertyName];
    }
}

#pragma mark - Private

+ (NSSet *)p_propertyKeys {
    
    NSSet *cachedKeys = objc_getAssociatedObject(self, YHModelCachedPropertyKeysKey);
    if (cachedKeys != nil) return cachedKeys;
    
    NSMutableSet *keys = [NSMutableSet set];
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    for (int i=0; i<propertyCount; i++) {
        objc_property_t *property = propertyList + i;
        NSString *propertyName = [NSString stringWithCString:property_getName(*property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    
    objc_setAssociatedObject(self, YHModelCachedPropertyKeysKey, keys, OBJC_ASSOCIATION_COPY);
    
    return keys;
}


@end
