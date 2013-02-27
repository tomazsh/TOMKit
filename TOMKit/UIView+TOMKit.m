//
//  UIView+TOMKit.m
//  Scraps
//
//  Created by Tomaz Nedeljko on 14/1/13.
//  Copyright (c) 2013 Tomaz Nedeljko. All rights reserved.
//

#import "UIView+TOMKit.h"

@implementation UIView (TOMKit)

#pragma mark -
#pragma mark Instance Methods

#ifdef QUARTZCORE_H

- (UIImage *)imageByRenderingLayer
{
    return [self imageByRenderingLayerFrame:self.layer.bounds opaque:self.opaque];
}

- (UIImage *)imageByRenderingLayerFrame:(CGRect)frame opaque:(BOOL)opaque
{
    UIGraphicsBeginImageContextWithOptions(frame.size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contextRef, -frame.origin.x, -frame.origin.y);
    [self.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)imageByRenderingLayerCompletion:(void (^)(UIImage *))completion
{
    NSAssert(completion, @"Completion block is missing.");
    
    __block UIImage *image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        image = [self imageByRenderingLayer];
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion(image);
        });
    });
}

#endif

@end
