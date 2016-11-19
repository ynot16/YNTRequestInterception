//
//  ViewController.m
//  YNTRequestInterceptionDemo
//
//  Created by bori－applepc on 2016/11/19.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendRequest];
    // Do any additional setup after loading the view, typically from a nib.
}

// 简单的发送请求
- (void)sendRequest {
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer.acceptableContentTypes = [manger.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    manger.responseSerializer.acceptableContentTypes = [manger.responseSerializer.acceptableContentTypes setByAddingObject: @"text/plain"];
    [manger GET:@"https://www.ynot16.com?" parameters:@{@"name":@"ynot",@"city":@"Guangzhou"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

@end
