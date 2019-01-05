//
//  KKMainThreadMonitor.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/5.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "KKMainThreadMonitor.h"

@interface KKMainThreadMonitor () {
    int timeoutCount;
    CFRunLoopObserverRef observer;
    dispatch_semaphore_t semaphore;
    CFRunLoopActivity activity;
}
@end

@implementation KKMainThreadMonitor

+ (instancetype)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    KKMainThreadMonitor *moniotr = (__bridge KKMainThreadMonitor*)info;
    
    moniotr->activity = activity;
    
    dispatch_semaphore_t semaphore = moniotr->semaphore;
    dispatch_semaphore_signal(semaphore);
}

- (void)stop {
    if (!observer)
        return;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);
    observer = NULL;
}

- (void)start {
    if (observer)
        return;
    
    // 信号
    semaphore = dispatch_semaphore_create(0);
    
    // 注册RunLoop状态观察
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    observer = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                       kCFRunLoopAllActivities,
                                       YES,
                                       0,
                                       &runLoopObserverCallBack,
                                       &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        while (YES) {
            long st = dispatch_semaphore_wait(self->semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            if (st != 0) {
                if (!self->observer) {
                    self->timeoutCount = 0;
                    self->semaphore = 0;
                    self->activity = 0;
                    return;
                }
                
                if (self->activity==kCFRunLoopBeforeSources || self->activity==kCFRunLoopAfterWaiting)
                {
                    if (++self->timeoutCount < 5)
                        continue;
                    // 打印堆栈
                    NSLog(@"------------\n%@\n------------", @"堆栈");
                }
            }
            self->timeoutCount = 0;
        }
    });
}

@end
