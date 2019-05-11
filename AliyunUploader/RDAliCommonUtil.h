//
//  RDAliCommonUtil.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/11.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RDAliCommonUtil : NSObject


- (NSString *)encodeURLParameterString:(NSString *)originString;
- (NSArray *)getAllIvarNameOfClass:(Class)class;


@end

NS_ASSUME_NONNULL_END
