//
//  ToolNSObject.h
//  Daijiushi
//
//  Created by rsl on 15/4/13.
//  Copyright (c) 2015年 joj. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ToolNSObjectDelegate <NSObject>

-(void)toolClearFileSuccess;

@end
@interface ToolNSObject : NSObject
+(NSString *)toolGetTimeIntervalSince1970Time:(NSString *)time;
+(NSString *)toolGetTimeFromIntervalSince1970:(NSString *)timestr setFormatter:(NSString *)str;//得到时间
+(NSString *)toolGetToDayTimeFormatter:(NSString *)form;
+(NSString *)toolTimeIntervalSince1970Time:(NSString *)time AddingTimeInterval:(NSTimeInterval)ss;
+(NSTimeInterval)toolTimeCompareTimeIntervalSince1970Now:(NSString *)now Compa:(NSString *)com;
+(NSTimeInterval)toolTimeCompareTimeIntervalSince1970Compa:(NSString *)com;
+(NSString *)toolGetToDaySince1970TimeFormatter:(NSString *)form;

+(NSDate *)toolGetBeforeTimeFromTime:(NSString *)time IntervalSecond:(NSTimeInterval)Interval;
/*
 @缓存清理
 */
@property (assign,nonatomic) id<ToolNSObjectDelegate>delegate;
-(NSString *)toolFilePathsize;
- (void)toolClearFile;

/*
 @字体的view大小
 */
-(CGSize)toolTextSizeText:(NSString *)text witdh:(CGFloat)witdh Font:(CGFloat)font;
+(CGSize)toolTextSizeText:(NSString *)text witdh:(CGFloat)witdh Font:(UIFont *)font;
+(NSString *)toolTextNSString:(NSString *)Str strC:(NSString *)strC;

+ (NSString *)toolBase64EncodedStringFrom:(NSData *)data;

+(CGPoint)toolMovePointFrom:(CGPoint)point0 PointTo:(CGPoint)point1;
@end
