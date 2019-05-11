//
//  RDAliCommonUtil.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "RDAliCommonUtil.h"
#import <objc/message.h>

@implementation RDAliCommonUtil


/**
 ali sts 编码规则

 * UTF-8字符集进行URL编码
 * 对于字符 A-Z、a-z、0-9以及字符“- %2D”、“_ %5F”、“. %2E”、“~ %7E”不编码
 * 英文空格（ ）要被编码是%20，而不是加号（+ ）
 *   **编码   后   的字符串**    中加号（+）替换成%20、星号（*）替换成%2A、%7E替换回波浪号（~）
 *   **编码   前   的字符串**    中加好（+）被编码成  %2B。
 */
- (NSString *)encodeURLParameterString:(NSString *)originString {

        // 这样做是合并起始范围
        //    NSRange notEncodeRange = NSUnionRange(lowerChars, upperChars);
        //    notEncodeRange = NSUnionRange(notEncodeRange, numChars);

    NSRange lowerChars = NSMakeRange((unsigned int)'a', 26);
    NSMutableCharacterSet *lowerCharsSet = [NSMutableCharacterSet characterSetWithRange:lowerChars];

    NSRange upperChars = NSMakeRange((unsigned int)'A', 26);
    NSMutableCharacterSet *upperCharsSet = [NSMutableCharacterSet characterSetWithRange:upperChars];

    // range.location need unicode value
    NSRange numChars = NSMakeRange(48, 10);
    NSMutableCharacterSet *numCharsSet = [NSMutableCharacterSet characterSetWithRange:numChars];

    NSMutableCharacterSet *specialSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"-_.~"];

    [specialSet formUnionWithCharacterSet:lowerCharsSet];
    [specialSet formUnionWithCharacterSet:upperCharsSet];
    [specialSet formUnionWithCharacterSet:numCharsSet];

    NSString *encodedString = [originString stringByAddingPercentEncodingWithAllowedCharacters:specialSet];

    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%20"];

    return encodedString;
}


- (NSArray *)getAllIvarNameOfClass:(Class)class {
    if (!class) {
        return nil;
    }
    unsigned int count;
    objc_property_t *propertyLists = class_copyPropertyList(class, &count);
    NSMutableArray *propertyNameArray = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        objc_property_t property = propertyLists[i];
        NSString *propertyname = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];

        [propertyNameArray addObject:propertyname];;
    }
    return [propertyNameArray copy];
}


@end
