//
//  UIImage+TOMKit.m
//  TOMKit
//
//  Copyright (c) 2015 Tomaz Nedeljko (http://nedeljko.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIImage+TOMKit.h"
#import "UIScreen+TOMKit.h"

@interface UIImage (TOMKitPrivate)

#ifdef __IMAGEIO__

+ (UIImage *)tom_animatedImageWithAnimatedGIFImageSource:(CGImageSourceRef)source duration:(NSTimeInterval)duration;
+ (NSTimeInterval)tom_durationForGIFData:(NSData *)data;

#endif

@end

@implementation UIImage (TOMKitPrivate)

#pragma mark -
#pragma mark Class Methods

#ifdef __IMAGEIO__

+ (UIImage *)tom_animatedImageWithAnimatedGIFImageSource:(CGImageSourceRef)source duration:(NSTimeInterval)duration
{
    NSParameterAssert(source);
    
    __block UIImage *image;
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage) return nil;
        [images addObject:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
    }
    image = [UIImage animatedImageWithImages:images duration:duration];
        
    return image;
}

+ (NSTimeInterval)tom_durationForGIFData:(NSData *)data
{
    NSParameterAssert(data);
    
    __block CGFloat duration = 0;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        char graphicControlExtensionStartBytes[] = {0x21, 0xF9, 0x04};
        NSRange dataSearchLeftRange = NSMakeRange(0, data.length);
        while(YES) {
            NSRange frameDescriptorRange = [data rangeOfData:[NSData dataWithBytes:graphicControlExtensionStartBytes length:3]
                                                     options:NSDataSearchBackwards range:dataSearchLeftRange];
            if (frameDescriptorRange.location != NSNotFound) {
                NSData *durationData = [data subdataWithRange:NSMakeRange(frameDescriptorRange.location+4, 2)];
                unsigned char buffer[2];
                [durationData getBytes:buffer];
                CGFloat delay = (buffer[0] | buffer[1] << 8);
                duration += delay;
                dataSearchLeftRange = NSMakeRange(0, frameDescriptorRange.location);
            } else {
                break;
            }
        }
        duration /= 100.0f;
    });
    return duration;
}

#endif

@end

@implementation UIImage (NNKit)

#pragma mark -
#pragma mark Instance Methods

- (void)tom_imageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius completed:(void (^)(UIImage *image))completed
{
    [self tom_imageWithSize:size cornerRadius:cornerRadius borderWidth:0.0f borderColor:nil completed:completed];
}

- (void)tom_imageWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor completed:(void (^)(UIImage *image))completed
{
    NSParameterAssert(completed);
    
    __block UIImage *image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [self tom_imageWithSize:size radiiAtTopLeft:cornerRadius topRight:cornerRadius bottomRight:cornerRadius bottomLeft:cornerRadius borderWidth:borderWidth borderColor:borderColor foregroundColor:nil backgroundColor:[UIColor clearColor]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completed(image);
        });
    });
}

- (UIImage *)tom_imageWithSize:(CGSize)size radiiAtTopLeft:(CGFloat)topLeftRadius topRight:(CGFloat)topRightRadius bottomRight:(CGFloat)bottomRightRadius bottomLeft:(CGFloat)bottomLeftRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor
{
    backgroundColor = backgroundColor ?: [UIColor whiteColor];
    
    CGFloat alpha = 0.0f;
    [backgroundColor getWhite:nil alpha:&alpha];
    BOOL opaque = alpha == 1.0f;
    
    size = CGSizeMake(roundf(size.width), roundf(size.height));
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMake(1.0f, 0.0f, 0.0f, -1.0f, 0.0f, size.height));
    
    CGFloat fw = size.width;
    CGFloat fh = size.height;
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, CGRectMake(0.0f, 0.0f, fw, fh));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0.0f, fh/2.0f);
    CGPathAddArcToPoint(path, NULL, 0.0f, 0.0f, fw/2.0f, 0.0f, topLeftRadius);
    CGPathAddArcToPoint(path, NULL, fw, 0.0f, fw, fh/2.0f, topRightRadius);
    CGPathAddArcToPoint(path, NULL, fw, fh, fw/2.0f, fh, bottomRightRadius);
    CGPathAddArcToPoint(path, NULL, 0.0f, fh, 0.0f, fh/2.0f, bottomLeftRadius);
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextClip(context);
        
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, fw, fh), self.CGImage);

    if (foregroundColor) {
        CGContextAddPath(context, path);
        CGContextSetFillColorWithColor(context, foregroundColor.CGColor);
        CGContextFillPath(context);
    }
    
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, borderWidth*2.0f);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark -
#pragma mark Public class methods

#ifdef __IMAGEIO__

+ (NSUInteger)tom_numberOfImagesInData:(NSData *)data
{
    NSParameterAssert(data);
    
    __block NSUInteger count = 0;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
        count = CGImageSourceGetCount(source);
        CFRelease(source);
    });
    return count;
}

+ (UIImage *)tom_animatedImageWithGIFData:(NSData *)data
{
    NSParameterAssert(data);
    
    NSTimeInterval duration = [self tom_durationForGIFData:data];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    UIImage *image = [UIImage tom_animatedImageWithAnimatedGIFImageSource:source duration:duration];
    CFRelease(source);
    return image;
}

#endif

@end
