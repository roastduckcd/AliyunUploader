//
//  RDAliAssumeRoleModel.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RDAliAssumeRoleModel : NSObject


@property (nonatomic, copy, readonly) NSString *Action;
@property (nonatomic, copy, readonly) NSString *RoleArn;
@property (nonatomic, copy, readonly) NSString *RoleSessionName;
@property (nonatomic, copy, readonly) NSString *Policy;
@property (nonatomic, copy, readonly) NSString *Signature;
@property (nonatomic, strong, readonly) NSNumber *DurationSeconds;

- (instancetype)initWithRoleArn:(NSString *)roleArn AndSessionName:(NSString *)roleSessionName;
- (NSDictionary *)assumeRoleParameterDic;
- (void)setPolicy:(NSDictionary *)Policy;
- (void)setDurationSeconds:(NSNumber *)DurationSeconds;
- (void)setSignature:(NSString * _Nonnull)Signature;

@end

NS_ASSUME_NONNULL_END
