//
//  RDAliCommonModel.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "RDAliCommonModel.h"
#import "NSDate+RDDate.h"
#import "RDAliCommonUtil.h"


@interface RDAliCommonModel ()


@property (nonatomic, copy, readwrite) NSString *Format;
@property (nonatomic, copy, readwrite) NSString *Version;
@property (nonatomic, copy, readwrite) NSString *SignatureMethod;
@property (nonatomic, copy, readwrite) NSString *SignatureVersion;
@property (nonatomic, copy, readwrite) NSString *Timestamp;
@property (nonatomic, copy, readwrite) NSString *SignatureNonce;
@property (nonatomic, copy, readwrite) NSString *AccessKeyId;


@end


@implementation RDAliCommonModel


- (instancetype)initWithRandom:(NSString *)signatureNonce AndAccessKeyId:(NSString *)accessKeyId
{
    NSAssert(accessKeyId, @"Ali error : AccessKeyId must not be nil");
    self = [super init];
    if (self) {
        _Format = @"JSON";
        _Version = @"2015-04-01";
        _SignatureMethod = @"HMAC-SHA1";
        _SignatureVersion = @"1.0";
        _Timestamp = [NSDate get8601UTC];
        if (signatureNonce) {
            _SignatureNonce = signatureNonce;
        } else {
            _SignatureNonce = [NSDate getTimeStamp];
        }
        _AccessKeyId = accessKeyId;
    }
    return self;
}


- (NSDictionary *)commonParameterDic {

    RDAliCommonUtil *util = [[RDAliCommonUtil alloc] init];

    NSArray *keys = [util getAllIvarNameOfClass:[self class]];

    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (NSString *key in keys) {
        mDic[key] = [self valueForKey:key];
    }

    return [mDic copy];
}


@end
