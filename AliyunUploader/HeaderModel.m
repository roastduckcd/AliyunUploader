//
//  HaderModel.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "HeaderModel.h"
#import "NSDate+RDDate.h"
#import "NSString+HASH.h"
#import "NSDictionary+URL.h"
#import "RDAliCommonModel.h"
#import "RDAliAssumeRoleModel.h"
#import "RDAliCommonUtil.h"


#define AccessKeyId     @""
#define AccessKeySecret @""
#define RoleArn         @""


@interface HeaderModel ()


@property (nonatomic, strong) RDAliAssumeRoleModel *assume;


@end


@implementation HeaderModel


- (NSString *)parameterString {
    return [[self parameterBody] httpGETUrlEncodeWithKeyAscend];
}


- (NSDictionary *)parameterBody {

    NSString *urlToSign = [self componentParameterBodyToString];

    NSString *signature = [self getHMACAndBase64:urlToSign];

    [self.assume setSignature:signature];

    if (signature) {
        return self.assume.assumeRoleParameterDic;
    } else {
        return nil;
    }
}


- (NSDictionary *)parameterBodyWithoutSignatureKey {

    RDAliCommonModel *common = [[RDAliCommonModel alloc] initWithRandom:nil AndAccessKeyId:AccessKeyId];
    NSDictionary *commonDic = [common commonParameterDic];

    self.assume = [[RDAliAssumeRoleModel alloc] initWithRoleArn:RoleArn AndSessionName:@"injectMWeb"];
    NSDictionary *assumeDic = [self.assume assumeRoleParameterDic];

    NSMutableDictionary *parameterDic = [commonDic mutableCopy];
    [parameterDic addEntriesFromDictionary:assumeDic];

    return parameterDic;
}


- (NSString *)componentParameterBodyToString{

    NSAssert(_httpMethod != nil && ![_httpMethod isEqualToString:@""], @"need set the http method");

    RDAliCommonUtil *util = [[RDAliCommonUtil alloc] init];

    NSDictionary *paraDicToSign = [self parameterBodyWithoutSignatureKey];

    NSArray *ascedKeys = [self ascKeysInParameterDic:paraDicToSign];

    NSMutableString *mComponentedString = [NSMutableString string];
    for (NSString *key in ascedKeys) {
        id value = [paraDicToSign objectForKey:key];
        NSString *valueStr = [NSString stringWithFormat:@"%@", value];

        NSString *encodedKey = [util encodeURLParameterString:key];
        NSString *encodedValue = [util encodeURLParameterString:valueStr];

        NSString *appendedString = [encodedKey stringByAppendingFormat:@"=%@", encodedValue];
        [mComponentedString appendFormat:@"&%@",appendedString];
    }

    // remove first &
    mComponentedString = [[mComponentedString substringFromIndex:1] mutableCopy];

    NSString *encodedParameterUrl = [util encodeURLParameterString:mComponentedString];

    NSString *URLStringToSign = [NSString stringWithFormat:@"%@&%@&%@", _httpMethod, [util encodeURLParameterString:@"/"], encodedParameterUrl];

    return URLStringToSign;
}


- (NSArray *)ascKeysInParameterDic:(NSDictionary *)parameterDic {

    NSArray *sortedKeys = [parameterDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2 options:NSLiteralSearch];
        return result;
    }];
    return sortedKeys;
}


/**
 hash : using SHA1
 */
- (NSString *)getHMACAndBase64:(NSString *)originString {

    //    key = @"testsecret&";
    //    originString = @"GET&%2F&AccessKeyId%3Dtestid%26Action%3DAssumeRole%26Format%3DJSON%26RoleArn%3Dacs%253Aram%253A%253A1234567890123%253Arole%252Ffirstrole%26RoleSessionName%3Dclient%26SignatureMethod%3DHMAC-SHA1%26SignatureNonce%3D571f8fb8-506e-11e5-8e12-b8e8563dc8d2%26SignatureVersion%3D1.0%26Timestamp%3D2015-09-01T05%253A57%253A34Z%26Version%3D2015-04-01"
    //    result = @"gNI7b0AyKZHxDgjBGPDgJ1Ce3L4="

    NSString *key = [NSString stringWithFormat:@"%@&", AccessKeySecret];
    NSData *hmacData = [originString HMACString:key option:RDHASHOptionSHA1];
    return [hmacData base64EncodedStringWithOptions:0];
}


@end
