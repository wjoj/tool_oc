//
//  UIImage+Tool.h
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

+ (UIImage *)imageViewFiltrationImage:(UIImage *)image withBlurLevel:(CGFloat)blur ;

+(UIImage *)imageCreateCarveUp:(UIImage *)image sizeW:(CGFloat)sWitch sizeH:(CGFloat)sHeight
                       upWitch:(CGFloat)witch upHeight:(CGFloat)height;
+(NSString *)imageTurnBase64:(UIImage *)image;
-(CGFloat)imageGetWithFromImageHeight:(CGFloat)Height;
-(CGFloat)imageGetHeightFromImageWith:(CGFloat)With;
@end
