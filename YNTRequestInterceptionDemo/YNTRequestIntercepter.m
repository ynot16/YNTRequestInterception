//
//  YNTRequestIntercepter.m
//  YNTRequestInterceptionDemo
//
//  Created by bori－applepc on 2016/11/19.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

#import "YNTRequestIntercepter.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import <AFURLRequestSerialization.h>
#import "BRRequestView.h"



@implementation YNTRequestIntercepter

+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
//    NSString *urltest = getUserInfo(@"urltest");
//    if ([urltest isEqualToString:@"1"]) {
        [YNTRequestIntercepter sharedInstance];
        NSLog(@"%s",__PRETTY_FUNCTION__);
//    }
    
}

/*
 
 按道理来说，这个sharedInstance单例方法是可以放在头文件的，但是对于目前这个应用来说，暂时还没有放出去的必要
 
 当业务方对这个单例产生配置需求的时候，就可以把这个函数放出去
 */
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YNTRequestIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YNTRequestIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        /* 在这里做好方法拦截 */
        [AFHTTPRequestSerializer aspect_hookSelector:@selector(requestWithMethod:URLString:parameters:error:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo, NSString *method, NSString *URLString, id parameters, NSError *__autoreleasing *error){
            [self requestWithMethod:method URLString:URLString parameters:parameters error:error serialization:[aspectInfo instance]];
        } error:NULL];
    }
    return self;
}

#pragma mark - fake methods
- (void )requestWithMethod:(NSString *)method
                 URLString:(NSString *)URLString
                parameters:(id)parameters
                     error:(NSError *__autoreleasing *)error
             serialization:(AFHTTPRequestSerializer *)serialization {
    BRRequestView *view = [BRRequestView loadFromNib];
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:NULL];
    NSString *para = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // 构造URL
    NSString *query = AFQueryStringFromParameters(parameters);
    NSString *URL = [URLString stringByAppendingString:query];
    view.urlView.text = [NSString stringWithFormat:@"参数 = %@,\n URL = %@", para, URL];
    view.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 154);
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

@end
