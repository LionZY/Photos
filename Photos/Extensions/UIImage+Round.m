//
//  UIImage+Round.m
//  Photos
//
//  Created by Lion on 2021/6/5.
//

#import "UIImage+Round.h"

#define ImagePrefix @"ImageRound"

@implementation UIImage(Round)

static void addRoundedRectToPath(CGContextRef context,
                                 CGRect rect,
                                 float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (id)createRoundedRectImage:(UIImage *)image withKey:(NSString *)key{
    
    if (key && [key hasPrefix:[NSString stringWithFormat:@"%@", ImagePrefix]]) {
        
        NSArray *preArray = [key componentsSeparatedByString:[NSString stringWithFormat:@"%@", ImagePrefix]];
        CGSize imageSize;
        
        if ([preArray count] > 2) {
            NSString *sizeStr = [preArray objectAtIndex:1];
            NSArray *sizeArray = [sizeStr componentsSeparatedByString:@"x"];
            float width = [[sizeArray objectAtIndex:0] floatValue];
            float height = [[sizeArray objectAtIndex:1] floatValue];
            if (width > 0 && height > 0) {
                if (width>height) {
                    imageSize = CGSizeMake(width * 2, width * 2);
                } else {
                    imageSize = CGSizeMake(height * 2, height * 2);
                }
            } else {
                imageSize = CGSizeMake(160, 160);
            }
        } else {
            
            if (image.size.height > image.size.width) {
                imageSize = CGSizeMake(image.size.height, image.size.height);
            } else{
                imageSize = CGSizeMake(image.size.width, image.size.width);
            }
            
            if (imageSize.height > 160) {
                imageSize = CGSizeMake(160, 160);
            }
        }

        int w = imageSize.width;
        int h = imageSize.height;
        int radius = imageSize.width/2;
        
        UIImage *img = image;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
        CGRect rect = CGRectMake(0, 0, w, h);
        
        CGContextBeginPath(context);
        addRoundedRectToPath(context, rect, radius, radius);
        CGContextClosePath(context);
        CGContextClip(context);
        CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        img = [UIImage imageWithCGImage:imageMasked];
        
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);
        CGImageRelease(imageMasked);
        return img;
    } else {
        return image;
    }
}

+ (id)createRoundedRectImage:(UIImage *)image size:(CGSize)size radius:(int)radius{
    
    size = CGSizeMake(size.width * 2, size.height * 2);
    radius = radius * 2;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 4 * size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    return img;
}


@end
