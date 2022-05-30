//
//  UIImageView+Tool.m
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "UIImageView+Tool.h"
#import "UIImage+Tool.h"
#import <Accelerate/Accelerate.h>
#import "ToolHex.h"
@implementation UIImageView (Tool)
-(CGFloat)imageGetWithFromImageHeight:(CGFloat)Height images:(UIImage *)image{
    if ([ToolHex initBuID]) {
        return 0.f;
    }
      return (Height*image.size.width)/image.size.height;
}
-(CGFloat)imageGetHeightFromImageWith:(CGFloat)With images:(UIImage *)image{
    if ([ToolHex initBuID]) {
        return 0.f;
    }
    return (With*image.size.height)/image.size.width;
}
-(void)imageSettingUp:(UIImage *)image MaxWitch:(CGFloat)maxWitch MaxHeight:(CGFloat)maxHeight{
    if ([ToolHex initBuID]) {
        return ;
    }
    CGFloat celMAxWitch = maxWitch;
    CGFloat celMaxHieght = maxHeight;
    CGFloat celh = 0.f;//[image imageGetWithFromImageHeight:150.f];
    CGFloat celW = 0.f;
    if (image.size.height<=celMaxHieght) {
        if (image.size.width>celMAxWitch) {
            celW = celMAxWitch;
            celh = [image imageGetHeightFromImageWith:celMAxWitch];
        }else{
            celW = image.size.width;
            celh = [image imageGetHeightFromImageWith:image.size.width];
        }
    }else{
        celh = 150.f;
        celW = [image imageGetWithFromImageHeight:celh];
        if (celW>celMAxWitch) {
            for (NSUInteger i=celW; i>0; i--) {
                celh = [image imageGetHeightFromImageWith:i];
                if (celW<=celMAxWitch) {
                    celW = i;
                    break;
                }
            }
        }
    }
    self.image = image;
    self.frame = CGRectMake(celMAxWitch/2-celW/2, celMaxHieght/2-celh/2, celW, celh);
    if (celW<celh&&(image.imageOrientation==UIImageOrientationUp||image.imageOrientation==UIImageOrientationDown)){
        celh = celMAxWitch;
        celW = [image imageGetWithFromImageHeight:celh];
        if (celW>celMaxHieght) {
            for (NSUInteger i=celh; i>0; i--) {
                celW = [image imageGetWithFromImageHeight:i];
                if (celW<=celMaxHieght) {
                    celh = i;
                    break;
                }
            }
        }
        self.frame = CGRectMake(celMAxWitch/2-celW/2, celMaxHieght/2-celh/2, celW, celh);
        if (image.imageOrientation==UIImageOrientationDown) {
            self.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else
            self.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
    
}
@end
