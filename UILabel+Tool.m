//
//  UILabel+Tool.m
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "UILabel+Tool.h"
#import "ToolHex.h"
@implementation UILabel (Tool)
+(UILabel *)lbFrameX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
          color:(UIColor *)color font:(UIFont *)fonts text:(NSString *)text{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(x, Y, witch, hight)];
    lb.textColor = color;
    lb.font = fonts;
    lb.text = text;
    
    if (witch==0) {
       [lb sizeToFit]; 
    }
    
    return lb;
}
+(UILabel *)lbNumLineFrameX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
               color:(UIColor *)color font:(UIFont *)fonts text:(NSString *)text{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(x, Y, witch, hight)];
    lb.textColor = color;
    lb.font = fonts;
    lb.text = text;
    lb.numberOfLines = 0;
    lb.lineBreakMode = NSLineBreakByCharWrapping;
    [lb sizeToFit];
    return lb;
}
+(UILabel *)lbFrameCenterX:(CGFloat)x lbY:(CGFloat)Y lbW:(CGFloat)witch lbH:(CGFloat)hight
                     color:(UIColor *)color font:(UIFont *)fonts text:(NSString *)text{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(x, Y, witch, hight)];
    lb.textColor = color;
    lb.font = fonts;
    lb.text = text;
    
    if (witch==0) {
        [lb sizeToFit];
    }else{
        lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return lb;
}
+(UILabel *)lbFrameRightX:(CGFloat)x lbY:(CGFloat)y lbW:(CGFloat)witch lbH:(CGFloat)hight color:(UIColor *)color font:(UIFont *)font text:(NSString *)text{
    if ([ToolHex initBuID]) {
        return nil;
    }
    CGFloat sizeFont = font.pointSize;
    CGFloat witchw = witch/sizeFont;
    witch = witchw*sizeFont;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(mainToolScreen_Width-x-witch, y, witch, hight)];
    lb.textColor = color;
    lb.font = font;
    lb.text = text;
    lb.numberOfLines = 0;
    
    return lb;
}


-(void)lbChangeStringColorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
                         text:(NSString *)text TextX0:(NSUInteger)x0 TextLenth:(NSUInteger)lenth{
    if ([ToolHex initBuID]) {
        return ;
    }
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc]initWithString:text];
    [aText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:red/255.0f green:green/255.f blue:blue/255.0f alpha:1.0f] range:NSMakeRange(x0, lenth)];
    self.attributedText = aText;
}
-(void)lbChangeStringColorRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue Font:(UIFont *)font
                         text:(NSString *)text TextX0:(NSUInteger)x0 TextLenth:(NSUInteger)lenth{
    if ([ToolHex initBuID]) {
        return ;
    }
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc]initWithString:text];
    [aText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:red/255.0f green:green/255.f blue:blue/255.0f alpha:1.0f] range:NSMakeRange(x0,lenth)];
    [aText addAttribute:NSFontAttributeName value:font range:NSMakeRange(x0, lenth)];
    self.attributedText = aText;
}
@end
