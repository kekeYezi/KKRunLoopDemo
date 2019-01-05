//
//  ViewController.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/2.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllers/MainThreadMonitorViewController.h"
#import "ViewControllers/ThreadAliveViewController.h"
#import "ViewControllers/AsyncLayeViewController.h"
#import "ViewControllers/TimerViewController.h"
#import "ViewControllers/ImageLoadViewController.h"
#import "ViewControllers/RestartViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = @[@"主线程卡顿检测", @"线程保活", @"异步渲染", @"NSTimer", @"大图加载", @"应用复活"];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier  = @"KKRunLoopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell                         = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.data[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0: {
            controller = [[MainThreadMonitorViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1: {
            controller = [[ThreadAliveViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 2: {
            controller = [[AsyncLayeViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 3: {
            controller = [[TimerViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 4: {
            controller = [[ImageLoadViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 5: {
            controller = [[RestartViewController alloc] init];
            controller.title = self.data[indexPath.row];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
