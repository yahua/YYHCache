//
//  ViewController.m
//  YYHCacheDemo
//
//  Created by 王时温 on 16/1/21.
//  Copyright © 2016年 wangsw. All rights reserved.
//

#import "ViewController.h"
#import "YYHCache.h"
#import "YYHDiskCache.h"
#import "YYHMemoryCache.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self setTest];
}

- (void)setTest {
    
    YYHDiskCache *diskCache = [[YYHDiskCache alloc] initWithName:@"yahua"];
    YYHMemoryCache *memoryCache = [YYHMemoryCache new];
    
    NSMutableArray *keys = [NSMutableArray new];
    NSMutableArray *values = [NSMutableArray new];
    int count = 200000;
    for (int i = 0; i < count; i++) {
        NSObject *key;
        key = [NSString stringWithFormat:@"%d", i]; // avoid string compare
        //key = @(i).description; // it will slow down NSCache...
        //key = [NSUUID UUID].UUIDString;
        NSData *value = [NSData dataWithBytes:&i length:sizeof(int)];
        [keys addObject:key];
        [values addObject:value];
    }
    
    NSTimeInterval begin, end, time;
    
    
    printf("\n===========================\n");
    printf("Memory cache set 200000 key-value pairs\n");
    
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            [memoryCache setObject:values[i] forKey:keys[i]];
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                [memoryCache setObject:values[i] forKey:keys[i]];
//            });
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("YYHMemoryCache:   %8.2f\n", time * 1000);
    count = 1000;
    begin = CACurrentMediaTime();
    @autoreleasepool {
        for (int i = 0; i < count; i++) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [diskCache setObject:values[i] forKey:keys[i]];
            });
        }
    }
    end = CACurrentMediaTime();
    time = end - begin;
    printf("YYHDiskCache:     %8.2f\n", time * 1000);
    [diskCache removeAllObjects];
    
}

- (void)readTest {
    
        printf("\n===========================\n");
        printf("Memory cache get 200000 key-value pairs\n");
        NSTimeInterval begin, end, time;
        begin = CACurrentMediaTime();
    NSMutableArray *keys = [NSMutableArray new];
    NSMutableArray *values = [NSMutableArray new];
    int count = 200000;
        @autoreleasepool {
            for (int i = 0; i < count; i++) {
                [[YYHCache shareInstance] objectForKey:keys[i]];
            }
        }
        end = CACurrentMediaTime();
        time = end - begin;
        printf("YYHCache:   %8.2f\n", time * 1000);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
