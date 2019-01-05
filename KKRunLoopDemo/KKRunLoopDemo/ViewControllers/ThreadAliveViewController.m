//
//  ThreadAliveViewController.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "ThreadAliveViewController.h"

@interface ThreadAliveViewController ()

@property (nonatomic, strong) KKThread *aliveThread;

@end

@implementation ThreadAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self keepAliveThread];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
// 会崩溃
//    [self.aliveThread start];
    
// 会重复创建和销毁线程
//    [self remakeThread];
    [self performSelector:@selector(caculate) onThread:self.aliveThread withObject:nil waitUntilDone:NO];
}

// 每次执行异步任务 线程会不断的创建和销毁
- (void)remakeThread {
    KKThread *therad = [[KKThread alloc] initWithTarget:self selector:@selector(caculate) object:nil];
    [therad setName:@"KKThread"];
    [therad start];
}

// 尝试使用全局变量持有局部线程变量：
// 发现再次调用这个线程(即调用[therad start] 而不是用[self performSelector:@selector(caculate) onThread:self.aliveThread withObject:nil waitUntilDone:NO];) 会崩溃
//  Apple不允许这种方式长期持有线程。

/*
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[KKThread start]: attempt to start the thread again'
  libc++abi.dylib: terminating with uncaught exception of type NSException
*/
- (void)keepAliveThread {
    if (!self.aliveThread) {
        KKThread *therad = [[KKThread alloc] initWithTarget:self selector:@selector(caculate) object:nil];
        [therad setName:@"KKThread"];
        self.aliveThread = therad;
    }
    
    [self.aliveThread start];
}

- (void)caculate {
    NSLog(@"%@----执行子线程任务",[NSThread currentThread]);
    
    // 双for循环只是模拟的 耗时操作，实际 情况子线程处理的场景比这复杂很多
    long sum = 0;
    for (int i = 0; i <100 ; i ++) {
        for (int j = 0; j < 100; j ++) {
            sum = i + j;
        }
    }
    NSLog(@"计算结束 结果: %ld", sum);
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //下面这一行必须加，否则RunLoop无法正常启用。我们暂时先不管这一行的意思，稍后再讲。
    [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
    //让RunLoop跑起来
    [runLoop run];
    
    NSLog(@"测试是否执行");
}

@end


@implementation KKThread

- (void)dealloc {
    NSLog(@"KKThread 释放了");
}

@end
