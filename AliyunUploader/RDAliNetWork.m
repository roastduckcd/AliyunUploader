//
//  AliyunOSSMac.m
//  AliyunUploader
//
//  Created by yang song on 2019/4/27.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "RDAliNetWork.h"
#import <AppKit/AppKit.h>
#import "HeaderModel.h"


//#define BaseUrlString @"https://sts.aliyuncs.com"
#define  BaseUrlString @"https://sts.cn-hangzhou.aliyuncs.com"

@implementation RDAliNetWork


- (void)accessForToken {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];

    HeaderModel *hm = [[HeaderModel alloc] init];
    hm.httpMethod = @"GET";
    NSString *parameterStr = [hm parameterString];

    NSString *urlStr = [NSString stringWithFormat:@"%@/?%@", BaseUrlString, parameterStr];

    NSURL *url = [NSURL URLWithString:urlStr];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"identity" forHTTPHeaderField:@"Accept-Encoding"];
    [request setHTTPMethod:@"GET"];

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            NSLog(@" === %@", error.userInfo);
        } else {
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                NSLog(@" json === %@", error.userInfo);
            } else {
                NSLog(@"get data = %@", result);
            }
        }
    }];
    [task resume];

}



@end
