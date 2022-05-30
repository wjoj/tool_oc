//
//  UIImage+Tool.m
//  Daijiushi
//
//  Created by rsl on 15/3/30.
//  Copyright (c) 2015年 joj. All rights reserved.
//

#import "UIImage+Tool.h"
#import <Accelerate/Accelerate.h>
#import "ToolHex.h"
@implementation UIImage (Tool)
+ (UIImage *)imageViewFiltrationImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ([ToolHex initBuID]) {
        return nil;
    }
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    UIImage * _tmpImage = [image copy];
    
    CGImageRef img = _tmpImage.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
-(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor >heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
    
        if (widthFactor >heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor< heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    UIGraphicsEndImageContext();
    return newImage;
}
+(UIImage *)imageCreateCarveUp:(UIImage *)image sizeW:(CGFloat)sWitch sizeH:(CGFloat)sHeight
                       upWitch:(CGFloat)witch upHeight:(CGFloat)height{
    if ([ToolHex initBuID]) {
        return nil;
    }
    UIImage *imageNew =  [image imageByScalingAndCroppingForSize:CGSizeMake(sWitch, sHeight)];
    CGImageRef imageRef = imageNew.CGImage;
    CGRect rect = CGRectMake(0, 0, witch, height);
    CGImageRef imageRectRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *newImage = [[UIImage alloc]initWithCGImage:imageRectRef];
    return newImage;
}

+(NSString *)imageTurnBase64:(UIImage *)image{
    if ([ToolHex initBuID]) {
        return nil;
    }
    NSData *dataImage = UIImageJPEGRepresentation(image, 1.f);
    return  [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(CGFloat)imageGetWithFromImageHeight:(CGFloat)Height{
    if ([ToolHex initBuID]) {
        return 0.f;
    }
    return (Height*self.size.width)/self.size.height;
}
-(CGFloat)imageGetHeightFromImageWith:(CGFloat)With{
    if ([ToolHex initBuID]) {
        return 0.f;
    }
    return (With*self.size.height)/self.size.width;
}
@end
