//
//  RDAliCommonModel.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RDAliCommonModel : NSObject


@property (nonatomic, copy, readonly) NSString *Version;
@property (nonatomic, copy, readonly) NSString *SignatureMethod;
@property (nonatomic, copy, readonly) NSString *SignatureVersion;
@property (nonatomic, copy, readonly) NSString *Format;
/** UTC: YYYY-MM-DDThh:mm:ssZ */
@property (nonatomic, copy, readonly) NSString *Timestamp;
/** unique random */
@property (nonatomic, copy, readonly) NSString *SignatureNonce;
@property (nonatomic, copy, readonly) NSString *AccessKeyId;

- (instancetype)initWithRandom:(NSString * _Nullable)signatueNonce AndAccessKeyId:(NSString *)accessKeyId;

- (NSDictionary *)commonParameterDic;


@end

NS_ASSUME_NONNULL_END
