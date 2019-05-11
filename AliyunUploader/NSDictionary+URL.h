//
//  NSDictionary+URL.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/9.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (URL)


- (NSString *)httpGETUrlEncodeWithKeyAscend;
- (NSString *)dictToJsonString;

@end

NS_ASSUME_NONNULL_END
