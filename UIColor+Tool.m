//
//  UIColor+Tool.m
//  Daijiushi
//
//  Created by rsl on 15/6/16.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "UIColor+Tool.h"
#import "ToolHex.h"
@implementation UIColor (Tool)
+(UIColor *)colorRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue{
    if ([ToolHex initBuID]) {
        return nil;
    }
    return [UIColor colorWithRed:red/255.f green:green/255.f blue:blue/255.f alpha:1.f];
}
@end
