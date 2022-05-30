//
//  UIView+Tool.m
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "UIView+Tool.h"
#import "ToolHex.h"

@implementation UIView (Tool)
+(UIView *)viewFrameX:(CGFloat)x Y:(CGFloat)y withc:(CGFloat)witch height:(CGFloat)height color:(UIColor *)color{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UIView *vLine = [[UIView alloc]initWithFrame:CGRectMake(x, y, witch, height)];
    vLine.backgroundColor = color;
    
    return vLine;
}
+(void)viewLine:(CGFloat)y0 height:(CGFloat)height view:(id)view{
    if ([ToolHex initBuID]) {
        return ;
    }
    UIView *vlint = [UIView viewFrameX:0 Y:y0 withc:mainViewScreen_Width height:height color:UIViewColor242];
    [view addSubview:vlint];
}
-(void)viewShow{
    if ([ToolHex initBuID]) {
        return ;
    }
    self.transform =  CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 1;
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
        } completion:^(BOOL finished2) {
        }];
    }];
}
@end
