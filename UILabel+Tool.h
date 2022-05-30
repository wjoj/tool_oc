//
//  UILabel+Tool.h
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Tool)
+(UILabel *)lbFrameX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
          color:(UIColor *)color font:(UIFont *)font text:(NSString *)text;
+(UILabel *)lbNumLineFrameX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
                      color:(UIColor *)color font:(UIFont *)fonts text:(NSString *)text;
+(UILabel *)lbFrameCenterX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
                     color:(UIColor *)color font:(UIFont *)fonts text:(NSString *)text;
+(UILabel *)lbFrameRightX:(CGFloat)x lbY:(CGFloat)y lbW:(CGFloat)witch lbH:(CGFloat)hight
                    color:(UIColor *)color font:(UIFont *)font text:(NSString *)text;

-(void)lbChangeStringColorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
                         text:(NSString *)text TextX0:(NSUInteger)x0 TextLenth:(NSUInteger)lenth;
-(void)lbChangeStringColorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue Font:(UIFont *)font
                         text:(NSString *)text TextX0:(NSUInteger)x0 TextLenth:(NSUInteger)lenth;
@end
