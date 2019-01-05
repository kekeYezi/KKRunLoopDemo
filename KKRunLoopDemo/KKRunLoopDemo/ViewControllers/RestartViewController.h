//
//  RestartViewController.h
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

//  记录2019-1-5
//  问题1:为啥都用的同一个方法 重启 RunLoop ，这个思想是怎么来了？ Apple介绍么
//  问题2:即使重启RunLoop不崩溃了，后续是对App更好还是会代码更加不稳定的代价？
//  问题3:为什么只生效一次 第二次直接 拦截不住 直接崩溃？

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestartViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
