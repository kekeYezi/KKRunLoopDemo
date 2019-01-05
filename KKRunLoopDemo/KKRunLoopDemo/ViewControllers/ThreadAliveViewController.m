//
//  ThreadAliveViewController.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "ThreadAliveViewController.h"

@interface ThreadAliveViewController ()

@end

@implementation ThreadAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    KKThread *therad = [[KKThread alloc] initWithTarget:self selector:@selector(caculate) object:nil];
    [therad start];
    // Do any additional setup after loading the view.
}

- (void)caculate {
    long sum = 0;
    for (int i = 0; i <100 ; i ++) {
        for (int j = 0; j < 100; j ++) {
            sum = i + j;
        }
    }
    NSLog(@"计算结束 结果: %ld", sum);
}

@end


@implementation KKThread

- (void)dealloc {
    NSLog(@"KKThread 释放了");
}

@end
