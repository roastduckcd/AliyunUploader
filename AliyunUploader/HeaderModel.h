//
//  HaderModel.h
//  AliyunUploader
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeaderModel : NSObject


@property (nonatomic, strong) NSString *httpMethod;

- (NSDictionary *)parameterBody;
- (NSString *)parameterString;

@end

NS_ASSUME_NONNULL_END
