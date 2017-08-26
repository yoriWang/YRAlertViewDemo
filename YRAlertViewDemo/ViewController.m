//
//  ViewController.m
//  YRAlertViewDemo
//
//  Created by 王煜仁 on 2017/8/26.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "ViewController.h"
#import "YRAlertView.h"

#define TestItemArray @[@"item1", @"item2", @"item3", @"item4"]

@interface ViewController ()
@property (nonatomic, weak) UILabel *logLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     test code
     */
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat buttonX = 50.f;
    CGFloat buttonW = width - 2 * buttonX;
    CGFloat buttonH = buttonX;
    CGFloat buttonY = (height - buttonH) / 2;
    
    UILabel *logLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, width - 100, 20)];
    logLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:logLabel];
    self.logLabel = logLabel;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"show alert view" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showAlertViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

#pragma mark - init alert view
- (void)showAlertViewAction:(UIButton *)button {
    /*
     init alert view, set title and message
     */
    YRAlertView *alertView = [YRAlertView alertWithTitle:@"prompt" message:@"click your choice."];
    /*
     set item image and title. image is optional, title is required
     */
    [alertView showAlertMenuWithImageArray:nil titleArray:TestItemArray];
    /*
     itemTitleColor: this property can set item title color. default is black color
     */
    /*
     get item index and title by this block
     */
    __weak typeof(self) weakSelf = self;
    __weak typeof(YRAlertView) *weakAlertView = alertView;
    alertView.alertHandler = ^(NSInteger idx, NSString * _Nonnull title) {
        ///do something
        weakSelf.logLabel.text = [NSString stringWithFormat:@"index:%ld, title:%@", (long)idx, title];
        //remove from super view
        [weakAlertView dismissAlertView];
    };
    /*
     show alert view
     */
    [alertView showAlertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
