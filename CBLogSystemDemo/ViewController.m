//
//  ViewController.m
//  CBLogSystemDemo
//
//  Created by zcb on 15-3-14.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "GNUMLogSystem.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)openShowLogInfo
{
    [GNUMLogSystem activeShowLogInfo];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Show Log" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(openShowLogInfo) forControlEvents:UIControlEventTouchUpInside];
     button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:button];
    //[self redirectNSlogToDocumentFolder];
	// Do any additional setup after loading the view, typically from a nib.
    CBLog(@"%f",self.view.frame.size.height);
    CBLog(@"dddddddddddd");
    NSLog(@"dddd222");
    NSLog(@"%@",@"9393939393");
    NSLog(@"%@",@"这是测试项目");
    printf("ddssd\n");
    NSMutableArray *constraits = [NSMutableArray array];
    [constraits addObject:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [constraits addObject:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraints:constraits];
}
// 日志信息
- (void)redirectNSlogToDocumentFolder
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    // 获取当前时间
    NSDate *recordDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *locationString = [dateFormatter stringFromDate:recordDate];
    
    // 获取系统版本号
    float deviceCode=[[[UIDevice currentDevice] systemVersion] floatValue];
    
    // LOG文件名由:当前时间+系统版本号+.log组成
    NSString *fileName = [NSString stringWithFormat:@"%@  %.2f.log",locationString,deviceCode];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //    NSFileManager *defaultManager = [NSFileManager defaultManager];
    //    // 先删除已经存在的文件
    //    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    /** printf会向标准输出(stdout)打印
     *  NSLog则是向标准出错
     */
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
