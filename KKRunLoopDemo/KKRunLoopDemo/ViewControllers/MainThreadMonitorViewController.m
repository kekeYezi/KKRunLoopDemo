//
//  MainThreadMonitorViewController.m
//  KKRunLoopDemo
//
//  Created by keke on 2019/1/3.
//  Copyright © 2019 kekeyezi. All rights reserved.
//

#import "MainThreadMonitorViewController.h"
#import "KKMainThreadMonitor.h"
//#import "FluencyMonitor.h"

@interface MainThreadMonitorViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@end

@implementation MainThreadMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[KKMainThreadMonitor sharedInstance] start];
//    [[FluencyMonitor shareMonitor] start];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier  = @"KKRunLoopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell                         = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    if (indexPath.row % 100 == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld 我是卡顿行",indexPath.row];
//        sleep(1);
        [self lightTestActions];
    }
    
    return cell;
}

- (void)lightTestActions {
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int i = 0; i < 500000; i++) {
        for (int j = 0; j < 20; j++) {
            [str appendString:@"1"];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[KKMainThreadMonitor sharedInstance] stop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
