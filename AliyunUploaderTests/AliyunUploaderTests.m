//
//  AliyunUploaderTests.m
//  AliyunUploaderTests
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+RDDate.h"
#import "HeaderModel.h"
#import "NSDictionary+URL.h"
#import "NSString+HASH.h"

@interface AliyunUploaderTests : XCTestCase

@end

@implementation AliyunUploaderTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {

//    NSString *string = @"abc123*&+=#%<>[\\]{}`|";
//    NSCharacterSet *set1 = [NSCharacterSet characterSetWithCharactersInString:@"abc*&]{}"];
////    set1 = [NSCharacterSet characterSetWithRange:NSMakeRange(@"a".integerValue, 25)];
//    NSString *encoded1 = [string stringByAddingPercentEncodingWithAllowedCharacters:set1];
//
//
//    NSString *s = @"0123456789:=";
//    NSRange numChars = NSMakeRange(48, 10);
//    NSMutableCharacterSet *notEncodeSet = [NSMutableCharacterSet characterSetWithRange:numChars];
//
//
//    NSString *encodedString = [s stringByAddingPercentEncodingWithAllowedCharacters:notEncodeSet];

    NSString *str = @"GET&%2F&AccessKeyId%3Dtestid%26Action%3DAssumeRole%26Format%3DJSON%26RoleArn%3Dacs%253Aram%253A%253A1234567890123%253Arole%252Ffirstrole%26RoleSessionName%3Dclient%26SignatureMethod%3DHMAC-SHA1%26SignatureNonce%3D571f8fb8-506e-11e5-8e12-b8e8563dc8d2%26SignatureVersion%3D1.0%26Timestamp%3D2015-09-01T05%253A57%253A34Z%26Version%3D2015-04-01";

    HeaderModel *model = [[HeaderModel alloc] init];
    NSString *str1 = [model performSelector:@selector(getHMACAndBase64:) withObject:str];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
