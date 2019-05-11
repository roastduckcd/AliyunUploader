//
//  NSDate+RDDate.m
//  AliyunUploader
//
//  Created by yang song on 2019/5/8.
//  Copyright © 2019 yangsong. All rights reserved.
//

#import "NSDate+RDDate.h"

@implementation NSDate (RDDate)

+ (NSString *)getTimeStamp {

    NSDate *current = [NSDate date];
    NSTimeInterval timestamp = [current timeIntervalSince1970];

    return [NSString stringWithFormat:@"%ld", (NSInteger)timestamp];
}


/**
 UTC, standard ISO8601, formate YYYY-MM-DDThh:mm:ssZ

 @return UTC time string
 */
+ (NSString *)get8601UTC {

    NSDate *date = [NSDate date];

    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd hh:mm:ss";
    formatter.timeZone = timeZone;

    NSString *UTCTime = [formatter stringFromDate:date];
    NSString *formateUTC = [[UTCTime stringByReplacingOccurrencesOfString:@" " withString:@"T"] stringByAppendingString:@"Z"];

    return formateUTC;
}

@end
