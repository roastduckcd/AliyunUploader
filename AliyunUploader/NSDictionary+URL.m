//
//  NSDictionary+URL.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/9.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "NSDictionary+URL.h"

@implementation NSDictionary (URL)



/**
 formate : URLENCODE(key1=value1&key2=value2)
 */
- (NSString *)httpGETUrlEncodeWithKeyAscend {

    NSArray *ascedKeys = [self ascKeysInParameterDic];

    NSMutableString *joinedStr = [NSMutableString string];
    for (NSString *key in ascedKeys) {
        id object = [self objectForKey:key];
        // TODO: TODO - 不同类型的处理
#warning - 不同类型的处理
        if ([object isKindOfClass:[NSObject class]]) {
            [joinedStr appendFormat:@"&%@=%@", key, [object performSelector:@selector(description)]];
        } else {
            [joinedStr appendFormat:@"&%@=%@", key, object];
        }
    }

    NSString *urlStrToEncode = [joinedStr substringFromIndex:1];

    return urlStrToEncode;
}


- (NSArray *)ascKeysInParameterDic{

    NSArray *sortedKeys = [self.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    return sortedKeys;
}


- (NSString *)dictToJsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr = @"";
    if (error) {
        NSLog(@"json serialize failed-- %@", error.userInfo);
    } else {
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return jsonStr;
}


@end
