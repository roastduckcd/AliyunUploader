//
//  RDAliAssumeRoleModel.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "RDAliAssumeRoleModel.h"
#import "RDAliCommonUtil.h"
#import "NSDictionary+URL.h"


@interface RDAliAssumeRoleModel ()


@property (nonatomic, copy, readwrite) NSString *Action;
@property (nonatomic, copy, readwrite) NSString *RoleArn;
@property (nonatomic, copy, readwrite) NSString *RoleSessionName;
@property (nonatomic, copy, readwrite) NSString *Policy;
@property (nonatomic, copy, readwrite) NSString *Signature;
@property (nonatomic, strong, readwrite) NSNumber *DurationSeconds;
@property (nonatomic, strong) NSMutableDictionary *tempDic;


@end


@implementation RDAliAssumeRoleModel


- (instancetype)initWithRoleArn:(NSString *)roleArn AndSessionName:(NSString *)roleSessionName
{
    NSAssert(roleArn, @"Ali error : role arn must not be nil");
    NSAssert(roleSessionName && (roleSessionName.length > 1), @"Ali error : role session name must not be nil and less than a character");
    self = [super init];
    if (self) {
        _Action = @"AssumeRole";
        _RoleArn = roleArn;
        _RoleSessionName = roleSessionName;
        _tempDic = [NSMutableDictionary dictionary];
    }
    return self;
}


- (NSDictionary *)assumeRoleParameterDic {

    if (!_tempDic || (_tempDic.count < 4)) {
        RDAliCommonUtil *util = [[RDAliCommonUtil alloc] init];

        NSArray *keys = [util getAllIvarNameOfClass:[self class]];

        for (NSString *key in keys) {
            if ([key isEqualToString:@"tempDic"]) {
                continue;
            }
            id value = [self valueForKey:key];
            if (value) {
                _tempDic[key] = value;
            }
        }
    }

    return [_tempDic copy];
}



/**
 //    NSDictionary *policyDic = @{@"Statement":@[@{@"Action":@"oss:*",@"Effect":@"Allow",@"Resource": @"*"}],@"Version": @"1"};
 */
- (void)setPolicy:(NSDictionary *)policy {
    if (policy) {
        NSString *policyStr = [policy dictToJsonString];
        _Policy = policyStr;
        _tempDic[@"Policy"] = policyStr;
    }
}


- (void)setDurationSeconds:(NSNumber *)durationSeconds {
    if (durationSeconds) {
        _DurationSeconds = durationSeconds;
        _tempDic[@"DurationSeconds"] = durationSeconds;
    }
}


- (void)setSignature:(NSString * _Nonnull)Signature {
    if (Signature) {
        _Signature = Signature;
        _tempDic[@"Signature"] = Signature;
    }
}


@end
