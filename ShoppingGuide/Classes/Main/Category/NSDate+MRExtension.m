//
//  NSDate+MRExtension.m
//  MR_BSBDJ
//
//  Created by Andrew554 on 16/7/19.
//  Copyright © 2016年 SinObjectC. All rights reserved.
//

#import "NSDate+MRExtension.h"

@implementation NSDate (MRExtension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear {
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 创建的时间日期组件
    NSDateComponents *createComp = [calendar components:NSCalendarUnitYear fromDate:self];
    
    // 当前的时间日期组件
    NSDateComponents *nowComp = [calendar components:NSCalendarUnitYear fromDate:now];
    
    return createComp.year == nowComp.year;
}


/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday {
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *compareComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self toDate:now options:0];
    return compareComp.year == 0 && compareComp.month == 0 && compareComp.day == 1 ;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday {
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    [fmt setDateFormat:@"yyyy-MM-dd"];
    
    NSString *createStr = [fmt stringFromDate:self];
    
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [createStr isEqualToString:nowStr];
}

/**
 *  时间戳转换时间字符串
 */
+ (NSString *)dateWithTimeStamp:(NSString *)timeStampString {
    NSTimeInterval timeSta = [timeStampString doubleValue];
    NSDateFormatter *fmat = [[NSDateFormatter alloc] init];
    fmat.dateStyle = NSDateFormatterShortStyle;
    fmat.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSta];
    NSString *dateString = [fmat stringFromDate:date];
    return dateString;
    /**
     *public class func timeStampToDate(timeStamp:String) -> NSDate {
     
     let string = NSString(string: timeStamp)
     
     let timeSta:NSTimeInterval = string.doubleValue/1000
     
     let dfmatter = NSDateFormatter()
     
     dfmatter.dateStyle = .ShortStyle
     
     dfmatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
     
     let date = NSDate(timeIntervalSince1970: timeSta)
     
     return date
     }
     */
}
@end
