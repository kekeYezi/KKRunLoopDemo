//
//  ThreadAliveViewController.h
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

//  demo只演示了最基础的线程保活，其实还有很多更深的用法

/*
AF 2.X 经典代码
 
 + (NSThread *)networkRequestThread {
    static NSThread *_networkRequestThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _networkRequestThread = [[NSThread alloc] initWithTarget:self selector:@selector(networkRequestThreadEntryPoint:) object:nil];
        [_networkRequestThread start];
    });
    return _networkRequestThread;
 }
 
 + (void)networkRequestThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
 }

 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadAliveViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

@interface KKThread : NSThread

@end
