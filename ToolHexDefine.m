//
//  ToolHexDefine.m
//  ToolBox
//
//  Created by rsl on 15/7/6.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "ToolHexDefine.h"

@implementation ToolHexDefine
//DEBUG  模式下打印日志,当前行
+(void)toolReadDebugLine:(id)cd{
    DLog(@"line:%@",cd);
}
+(void)toolReadDebugLineNSlog:(id)cd{
    NSLogF(@"line:%@",cd);
}
+(void)toolReadLocFunctionName{
    ITTDPRINTMETHODNAME();
}
+(void)toolIttDERROR:(id)cd{
     //ITTDERROR(@"dd%@",@"dsf");
   // ITTDERROR();
   ITTDERROR(@"DERROR:%@",cd);
    
}
@end
