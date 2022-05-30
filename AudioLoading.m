//
//  AudioLoading.m
//  AudioLoading
//
//  Created by taiyan on 15/9/6.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "AudioLoading.h"
#import "ToolHex.h"
@interface AudioLoading(){
    NSString *filePath;
    NSString *filePathName;
    NSUInteger countL;
    NSString *filePlistPath;
    NSString *filePlist;
    NSURLConnection * DownConnection;
}
@property (strong, nonatomic) NSMutableData *dataAudio;
@end
@implementation AudioLoading
-(BOOL)voidDownFilePathUrl:(NSString *)url{
    filePathName = [self aduioPlayName:url];
    NSLog(@"%@",filePathName);
    filePlistPath = @"audioFileName.plist";
    self.strUrl = url;
    filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        
    }else{
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    filePlist = [NSString stringWithFormat:@"%@/%@",filePath,filePlistPath];
    if ([fileManager fileExistsAtPath:filePlist]) {
        
    }else{
        [fileManager createFileAtPath:filePlist contents:nil attributes:nil];
    }
    NSDictionary *dicName = [NSDictionary dictionaryWithContentsOfFile:filePlist];
    // NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    
    if ([dicName objectForKey:filePathName]==nil) {
        NSLog(@"no file have loading");
        
    }else{
        return YES;
    }
    if ([fileManager fileExistsAtPath:[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filePathName]]]) {
        NSLog(@"have file no load");
    }else{
        [fileManager createFileAtPath:[NSString stringWithFormat:@"%@/%@",filePath,filePathName] contents:nil attributes:nil];
    }
    return NO;
}
-(void)voidDownRequst:(NSString *)url{
    NSLog(@"loading");
    self.dataAudio = [NSMutableData data];
    NSURL *urlr = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlr];
    DownConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"loading%ld",countL++);
    [self.dataAudio appendData:data];
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    // NSLog(@"大小%ld",response.expectedContentLength);
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    countL = 0;
    if ([self.delagate respondsToSelector:@selector(AudioLoadingFail)]) {
        [self.delagate AudioLoadingFail];
    }
    NSLog(@"loadingerr");
}
-(void)audioLoadingStop{
    [DownConnection cancel];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"loadingOver");
    countL = 0;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:[NSString stringWithFormat:@"%@/%@",filePath,filePathName]];
    [fileHandle writeData:self.dataAudio];
    [fileHandle closeFile];
    NSDictionary *dicName = [NSDictionary dictionaryWithContentsOfFile:filePlist];
    NSMutableDictionary *dicd = [NSMutableDictionary dictionary];
    if (dicName==nil) {
        
    }else
        [dicd addEntriesFromDictionary:dicName];
    [dicd setObject:self.strdate forKey:filePathName];
    [dicd writeToFile:filePlist  atomically:YES];
    if ([self.delagate respondsToSelector:@selector(AudioLoadingFinish)]) {
        [self.delagate AudioLoadingFinish];
    }
}
-(NSString *)aduioPlayName:(NSString *)url{
    NSUInteger count = 0;
    if ([ToolHex initBuID]) {
        return @"";
    }
    for (NSUInteger i=url.length; i>0; i--) {
        if ([[url substringWithRange:NSMakeRange(i-1, 1)] isEqualToString:@"/"]) {
            count = i;
            break;
        }
    }
    return [url substringFromIndex:count];
}
+(NSString *)aduioPlayName:(NSString *)url{
    NSUInteger count = 0;
    if ([ToolHex initBuID]) {
        return @"";
    }
    for (NSUInteger i=url.length; i>0; i--) {
        if ([[url substringWithRange:NSMakeRange(i-1, 1)] isEqualToString:@"/"]) {
            count = i;
            break;
        }
    }
    return [url substringFromIndex:count];
}
+(NSData *)aduioPayurl:(NSString *)url{
    NSString * filePathu = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
    NSString *red = [filePathu stringByAppendingFormat:@"/%@",[self aduioPlayName:url]];
    return [NSData dataWithContentsOfFile:red];
}
+(NSURL *)aduiourlPayurl:(NSString *)url{
    NSString * filePathu = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
    NSString *red = [filePathu stringByAppendingFormat:@"/%@",[self aduioPlayName:url]];
    return [[NSURL alloc]initFileURLWithPath:red];
}
+(float)audioFileSize{
    NSString *Path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath :Path] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [Path stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize;
//    NSString *Path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:Path]) {
//        NSDictionary *dic = [fileManager attributesOfItemAtPath:Path error:nil];
//        return [[dic objectForKey:NSFileSize] floatValue];
//    }else{
//        
//    }
//    return 0.f;
}
+(BOOL)audioFileDele{
    NSString *Path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/audioLoad"]];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:Path error:nil]) {
        return YES;
    }
    return NO;
}

+(long long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
    
}
+(float)folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return (folderSize+[self audioFileSize])/(1024.0);
}
+(NSString *)audioFilePathsize
{
    if ([ToolHex initBuID]) {
        return @"0";
    }
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    float siez = [self folderSizeAtPath :cachPath];
    float sizeSum = siez ;
    NSString *clearSisz = nil;
    
    if (siez>=1024) {
        clearSisz = [NSString stringWithFormat:@"%.2fM",sizeSum/1024];
    }else{
        clearSisz = [NSString stringWithFormat:@"%.2fK",sizeSum];
    }
    return clearSisz;
}
+(void)audioClearFile{
    if ([ToolHex initBuID]) {
        return;
    }
    [self audioFileDele];
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
   // [ self performSelectorOnMainThread : @selector(clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
-(void)clearCachSuccess
{
   
}
@end
