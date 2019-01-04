//
//  RestartViewController.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "RestartViewController.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

NSString * const kSignalExceptionName = @"kSignalExceptionName";
NSString * const kSignalKey = @"kSignalKey";
NSString * const kCaughtExceptionStackInfoKey = @"kCaughtExceptionStackInfoKey";

@interface RestartViewController ()

@end

@implementation RestartViewController

void eHandler(NSException *exception){
    NSString *message = [NSString stringWithFormat:@"崩溃原因如下:\n%@\n%@",
                         [exception reason],
                         [[exception userInfo] objectForKey:kCaughtExceptionStackInfoKey]];
    NSLog(@"%@",message);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"程序崩溃了"
                                                    message:@"如果你能让程序起死回生，那你的决定是？"
                                                   delegate:nil
                                          cancelButtonTitle:@"崩就蹦吧"
                                          otherButtonTitles:@"起死回生", nil];
    [alert show];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (1) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
    
    CFRelease(allModes);
    
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    if ([[exception name] isEqual:kSignalExceptionName]) {
        kill(getpid(), [[[exception userInfo] objectForKey:kSignalKey] intValue]);
    } else {
        [exception raise];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSSetUncaughtExceptionHandler(&eHandler);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"复活";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *array =[NSArray array];
    NSLog(@"%@",[array objectAtIndex:1]);
}

@end
