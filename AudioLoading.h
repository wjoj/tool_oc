//
//  AudioLoading.h
//  AudioLoading
//
//  Created by taiyan on 15/9/6.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AudioLoadingDelegate <NSObject>

-(void)AudioLoadingFail;
-(void)AudioLoadingFinish;

@end
@interface AudioLoading : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (strong, nonatomic) NSString *strUrl;
@property (strong, nonatomic) NSString *strdate;
@property (assign ,nonatomic) id<AudioLoadingDelegate>delagate;
-(BOOL)voidDownFilePathUrl:(NSString *)url;
-(void)voidDownRequst:(NSString *)url;

+(NSString *)aduioPlayName:(NSString *)url;
+(NSData *)aduioPayurl:(NSString *)url;
+(NSURL *)aduiourlPayurl:(NSString *)url;
+(BOOL)audioFileDele;
-(void)audioLoadingStop;
+(NSString *)audioFilePathsize;
+(void)audioClearFile;
@end
