//
//  KKMainThreadMonitor.h
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/5.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

//  代码来源网络 tanhao Copyright © 2015年 Tencent.
//  网上的资料大同小异，核心思想还是监控RunLoop的两个状态 kCFRunLoopBeforeSources kCFRunLoopAfterWaiting
//  结合其他方案（https://www.jianshu.com/p/ea36e0f2e7ae）一起 可能会更准确

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKMainThreadMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
