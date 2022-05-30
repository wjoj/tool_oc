//
//  ToolNSObject.m
//  Daijiushi
//
//  Created by rsl on 15/4/13.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "ToolNSObject.h"
#import "ToolHex.h"
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
@implementation ToolNSObject

+(NSString *)toolGetTimeIntervalSince1970Time:(NSString *)time{
    if ([ToolHex initBuID]) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
   // NSTimeZone* timeZone = //[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSDate* dateBegin = [formatter dateFromString:time];
    NSString *timeInterval = [NSString stringWithFormat:@"%ld", (long)[dateBegin timeIntervalSince1970]];
    return timeInterval;
}
+(NSString *)toolGetTimeFromIntervalSince1970:(NSString *)timestr setFormatter:(NSString *)str{
    if ([ToolHex initBuID]) {
        return @"";
    }
   NSDate *dateBefin = [NSDate dateWithTimeIntervalSince1970:timestr.longLongValue];
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:str];//@"YYYY-MM-dd HH:mm:ss"
    NSString *Befin = [formatter2 stringFromDate:dateBefin];
    return Befin;
}
+(NSString *)toolGetToDayTimeFormatter:(NSString *)form{
    if ([ToolHex initBuID]) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:form];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
    
    NSDate* dateBegin = [NSDate date];
    NSString *timeInterval = [formatter stringFromDate:dateBegin];
    return timeInterval;
}
+(NSString *)toolGetToDaySince1970TimeFormatter:(NSString *)form{
    if ([ToolHex initBuID]) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:form];
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    //    [formatter setTimeZone:timeZone];
    
    NSDate* dateBegin = [NSDate date];
   // NSString *timeInterval = [formatter stringFromDate:dateBegin];
    NSString *timeInterval = [NSString stringWithFormat:@"%ld", (long)[dateBegin timeIntervalSince1970]];
    return timeInterval;
}

+(NSString *)toolTimeIntervalSince1970Time:(NSString *)time AddingTimeInterval:(NSTimeInterval)ss{
    if ([ToolHex initBuID]) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSDate* dateBegin = [formatter dateFromString:time];
    NSDate* dateBegins = [dateBegin dateByAddingTimeInterval:ss];
    NSString *timeInterval = [NSString stringWithFormat:@"%ld", (long)[dateBegins timeIntervalSince1970]];
    ///NSString *Befin = [formatter stringFromDate:dateBegins];
    return timeInterval;
}
+(NSTimeInterval)toolTimeCompareTimeIntervalSince1970Now:(NSString *)now Compa:(NSString *)com{
    if ([ToolHex initBuID]) {
        return 190;
    }
    NSDate *dateBefin = [NSDate dateWithTimeIntervalSince1970:now.longLongValue];
    NSDate *dateBefinCom = [NSDate dateWithTimeIntervalSince1970:com.longLongValue];
    return [dateBefinCom timeIntervalSinceDate:dateBefin];
}
+(NSTimeInterval)toolTimeCompareTimeIntervalSince1970Compa:(NSString *)com{
    if ([ToolHex initBuID]) {
        return 190;
    }
    NSDate *dateBefinCom = [NSDate dateWithTimeIntervalSince1970:com.longLongValue];
    return [dateBefinCom timeIntervalSinceNow];
}
+(id)toolGetWeekIntervalSince1970:(NSString *)strWeak weaks:(NSArray *)weaks{
    if ([ToolHex initBuID]) {
        return nil;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unt= NSWeekdayCalendarUnit;
    NSDate *dateBefin = [NSDate dateWithTimeIntervalSince1970:strWeak.longLongValue];
    comps = [calendar components:unt fromDate:dateBefin];
    return weaks[[comps weekday]-1];
}
/*时间*/
+(NSDate *)toolGetBeforeTimeFromTime:(NSString *)time IntervalSecond:(NSTimeInterval)Interval{
     NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
     [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:SS"];
     NSDate* strToDayDate = [formatter dateFromString:time];
    NSTimeInterval aTimeInterval = [strToDayDate timeIntervalSinceReferenceDate] - Interval;//60*60 *24*(uBeginWeak-i);
    return  [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
}
/*!
 @缓存清理
 */
-(long long) fileSizeAtPath:( NSString *) filePath{
    if ([ToolHex initBuID]) {
        return 0;
    }
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
    
}
-(float)folderSizeAtPath:( NSString *) folderPath{
    if ([ToolHex initBuID]) {
        return 0;
    }
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/(1024.0);
}
-(NSString *)toolFilePathsize
{
    if ([ToolHex initBuID]) {
        return @"0";
    }
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    float siez = [self folderSizeAtPath :cachPath];
    NSString *clearSisz = nil;
    if (siez>=1024) {
        clearSisz = [NSString stringWithFormat:@"%.2fM",siez/1024];
    }else{
       clearSisz = [NSString stringWithFormat:@"%.2fK",siez];
    }
    return clearSisz;
}
- (void)toolClearFile;
{
    if ([ToolHex initBuID]) {
        return;
    }
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSLog ( @"cachpath = %@" , cachPath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    [ self performSelectorOnMainThread : @selector(clearCachSuccess) withObject : nil waitUntilDone : YES ];
}

-(void)clearCachSuccess
{
    if ([ToolHex initBuID]) {
        return;
    }
    [self.delegate toolClearFileSuccess];
}
/*
 @字体的view大小
 */
-(CGSize)toolTextSizeText:(NSString *)text witdh:(CGFloat)witdh Font:(CGFloat)font{
    CGSize _size;
    if ([ToolHex initBuID]) {
        return _size;
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(witdh, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"TrebuchetMS" size:font],NSFontAttributeName, nil] context:nil];
        _size = tmpRect.size;
        CGSize _si = CGSizeMake(_size.width+1, _size.height+1);
        _size = _si;
    }else if ([[[UIDevice currentDevice]systemVersion]floatValue]<5.0){
        if (text==nil) {
            text = @"";
        }
        NSAttributedString *nsarr = [[NSAttributedString alloc]initWithString:text];
        //      CGRect tmpRect=  [nsarr boundingRectWithSize:CGSizeMake(witdh, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        
        CGRect tmpRects =  [nsarr boundingRectWithSize:CGSizeMake(witdh, 1000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        _size = tmpRects.size;
        CGSize _si = CGSizeMake(_size.width+1-0.10, _size.height+1-0.09);
        _size = _si;
    }else{
        CGSize _rect = [text sizeWithFont:[UIFont fontWithName:@"TrebuchetMS" size:font] constrainedToSize:CGSizeMake(witdh, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        _size = CGSizeMake(_rect.width+1, _rect.height+1);
    }
    return _size;
}
/*
 @字体的view大小
 */
+(CGSize)toolTextSizeText:(NSString *)text witdh:(CGFloat)witdh Font:(UIFont *)font{
    CGSize _size;
    if ([ToolHex initBuID]) {
        return _size;
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        CGRect tmpRect = [text boundingRectWithSize:CGSizeMake(witdh, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
        _size = tmpRect.size;
        CGSize _is = CGSizeMake(_size.width+1-0.10, _size.height+1-0.09);
        
        _size = _is;
    }else{
        CGSize _rect = [text sizeWithFont:font constrainedToSize:CGSizeMake(witdh, 1000) lineBreakMode:NSLineBreakByCharWrapping];
        _size = _rect;
    }
    return _size;
}
+(BOOL)toolTextContentDetection:(NSString *)text selText:(BOOL)selCom{
    if ([ToolHex initBuID]) {
        return YES;
    }
    if (text.length==0) {
        return YES;
    }
    if (selCom)
        for (NSUInteger i=0; i<text.length; i++) {
            if (![[text substringWithRange:NSMakeRange(i, 1)] isEqualToString:@" "]) {
                return NO;
            }
        }
    return YES;
}
+(NSString *)toolTextNSString:(NSString *)Str strC:(NSString *)strC{
    if ([ToolHex initBuID]) {
        return Str;
    }
    return [Str length]==0?strC:Str;
}
/*
 @base64
 */
+ (NSString *)toolBase64EncodedStringFrom:(NSData *)data
{
    if ([ToolHex initBuID]) {
        return @"";
    }
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        // Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}
/*
 @同向行
 */
+(CGPoint)toolMovePointFrom:(CGPoint)point0 PointTo:(CGPoint)point1{
    if ([ToolHex initBuID]) {
        return CGPointMake(0, 0);
    }
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat xi  = point0.x;
    CGFloat yi = point0.y;
    if (point1.x>point0.x) {
        x = point1.x - point0.x;
        xi = point0.x - x;
    }else if (point1.x<point0.x){
        x =  point0.x -point1.x;
        xi = point0.x + x;
    }else{
        xi = point0.x;
    }
    if (point1.y>point0.y) {
        y = point1.y - point0.y;
        yi = point0.y - y;
    }else if (point1.y<point0.y){
        y = point0.y -point1.y;
        yi = point0.y + y;
    }else{
        yi = point0.y;
    }
    return CGPointMake(xi, yi);
}


@end
