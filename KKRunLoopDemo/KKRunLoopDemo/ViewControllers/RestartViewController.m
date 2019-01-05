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

@interface RestartViewController ()

@end

@implementation RestartViewController

void eHandler(NSException *exception) {

    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (YES) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSSetUncaughtExceptionHandler(&eHandler);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"重启RunLoop";
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *array =[NSArray array];
    NSLog(@"%@",[array objectAtIndex:1]);
}

@end
