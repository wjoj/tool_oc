//
//  ToolHex.m
//  ToolBox
//
//  Created by rsl on 15/6/29.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "ToolHex.h"

@implementation ToolHex
+(BOOL)initBuID{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    if (![bundleIdentifier isEqualToString:budleIDS]) {
        return YES;
    }else{
       
    }
    
    return NO;
}
-(BOOL)initBuIDS{
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    if (![bundleIdentifier isEqualToString:budleIDS]) {
        return YES;
    }
    return NO;
}
@end
