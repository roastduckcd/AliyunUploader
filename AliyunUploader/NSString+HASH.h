//
//  NSString+HASH.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, RDHASHOption) {
    RDHASHOptionSHA1,
    RDHASHOptionSHA224,
    RDHASHOptionSHA256,
    RDHASHOptionSHA384,
    RDHASHOptionSHA512,
    RDHASHOptionMD5
};


@interface NSString (HASH)


- (NSString *)MD5String;

- (NSData *)SHAString:(RDHASHOption)option;

- (NSData *)HMACString:(NSString *)key option:(RDHASHOption)option;

- (NSString *)base64String;

@end


@interface NSString (URL)


- (NSString *)URLEncodedString:(NSString *)strToEncode;


@end

NS_ASSUME_NONNULL_END
