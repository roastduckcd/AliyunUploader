//
//  NSString+HASH.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "NSString+HASH.h"
#import <CommonCrypto/CommonCrypto.h>



@implementation NSString (HASH)


- (NSString *)MD5String {
    return nil;
}

- (NSData *)SHAString:(RDHASHOption)option {

    unsigned char* (*RD_SHA)(const void *data, CC_LONG len, unsigned char *md);
    uint8 RD_SHA_DIGEST_LENGTH = '\0';
    switch (option) {
        case RDHASHOptionSHA1:
            RD_SHA = CC_SHA1;
            RD_SHA_DIGEST_LENGTH = CC_SHA1_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA224:
            RD_SHA = CC_SHA224;
            RD_SHA_DIGEST_LENGTH = CC_SHA224_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA256:
            RD_SHA = CC_SHA256;
            RD_SHA_DIGEST_LENGTH = CC_SHA256_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA384:
            RD_SHA = CC_SHA384;
            RD_SHA_DIGEST_LENGTH = CC_SHA384_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA512:
            RD_SHA = CC_SHA512;
            RD_SHA_DIGEST_LENGTH = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            RD_SHA = NULL;
            break;
    }

    const char *utfString = self.UTF8String;
    uint8_t buffer[RD_SHA_DIGEST_LENGTH];
    RD_SHA(utfString, (CC_LONG)strlen(utfString), buffer);
    
    return [NSData dataWithBytes:buffer length:RD_SHA_DIGEST_LENGTH];
}


- (NSData *)HMACString:(NSString *)key option:(RDHASHOption)option {

    CCHmacAlgorithm algorithm = 0;
    uint8 RD_SHA_DIGEST_LENGTH = '\0';
    switch (option) {
        case RDHASHOptionSHA1:
            algorithm = kCCHmacAlgSHA1;
            RD_SHA_DIGEST_LENGTH = CC_SHA1_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA224:
            algorithm = kCCHmacAlgSHA224;
            RD_SHA_DIGEST_LENGTH = CC_SHA224_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA256:
            algorithm = kCCHmacAlgSHA256;
            RD_SHA_DIGEST_LENGTH = CC_SHA256_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA384:
            algorithm = kCCHmacAlgSHA384;
            RD_SHA_DIGEST_LENGTH = CC_SHA384_DIGEST_LENGTH;
            break;
        case RDHASHOptionSHA512:
            algorithm = kCCHmacAlgSHA512;
            RD_SHA_DIGEST_LENGTH = CC_SHA512_DIGEST_LENGTH;
            break;
        case RDHASHOptionMD5:
            algorithm = kCCHmacAlgMD5;
            RD_SHA_DIGEST_LENGTH = CC_MD5_DIGEST_LENGTH;
            break;
    }

    NSData *encodeKey = [key dataUsingEncoding:NSUTF8StringEncoding];

    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];

    unsigned char hmac[RD_SHA_DIGEST_LENGTH];
    CCHmac(algorithm, [encodeKey bytes], encodeKey.length, [data bytes], data.length, &hmac);

    return [NSData dataWithBytes:hmac length:RD_SHA_DIGEST_LENGTH];;
}


- (NSString *)base64String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *basedStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return basedStr;
}


@end



@implementation NSString (URL)



/**
 default to URLQueryAllowedCharacterSet : "#%<>[\]^`{|}
 */
#warning 并集、交集····
- (NSString *)URLEncodedString:(NSString *)strToIgnore {

    NSCharacterSet *set = nil;
    if (strToIgnore) {
        set = [NSCharacterSet characterSetWithCharactersInString:strToIgnore];
    } else {
        set = [NSCharacterSet URLQueryAllowedCharacterSet];
    }

    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}


@end
