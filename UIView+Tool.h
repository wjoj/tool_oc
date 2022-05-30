//
//  UIView+Tool.h
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import <UIKit/UIKit.h>
#define mainViewScreen_Width [UIScreen mainScreen].bounds.size.width
#define mainViewScreen_Height [UIScreen mainScreen].bounds.size.height

#define UIViewColor242 [UIColor colorWithRed:242.f/255 green:242.f/255 blue:242.f/255 alpha:1.f]
@interface UIView (Tool)
+(UIView *)viewFrameX:(CGFloat)x Y:(CGFloat)y withc:(CGFloat)witch height:(CGFloat)height color:(UIColor *)color;
+(void)viewLine:(CGFloat)y0 height:(CGFloat)height view:(id)view;
-(void)viewShow;
@end
