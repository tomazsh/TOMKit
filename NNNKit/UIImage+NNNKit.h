//
//  UIImage+NNNKit.h
//  NNNKit
//
//  Copyright (c) 2013 Tomaz Nedeljko (http://nedeljko.com)
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 The `UIImage(NNNKit)` protocol extends `UIImage`.
 */
@interface UIImage (NNNKit)

/// ------------------------
/// Creating Bordered Images
/// ------------------------

/**
 Creates a new image from the receiver and supplied parameters in the background and returns it in a block.
 
 @param size Size of the new image.
 @param cornerRadius Corner radius.
 @param completed A block to be executed when an image is created. This block takes the newly created image as its sole parameter.
 
 @return An `UIImage` object.
 */
- (void)imageWithSize:(CGSize)size
         cornerRadius:(CGFloat)cornerRadius
            completed:(void (^)(UIImage *image))completed;

/**
 Creates a new image from the receiver and supplied parameters in the background and returns it in a block.
 
 @param size Size of the new image.
 @param cornerRadius Corner radius.
 @param borderWidth Border width.
 @param borderColor Border color. May be `nil`.
 @param completed A block to be executed when an image is created. This block takes the newly created image as its sole parameter.
 
 @return An `UIImage` object.
 */
- (void)imageWithSize:(CGSize)size
         cornerRadius:(CGFloat)cornerRadius
          borderWidth:(CGFloat)borderWidth
          borderColor:(UIColor *)borderColor
            completed:(void (^)(UIImage *image))completed;

/**
 Creates a new image from the receiver and supplied parameters.
 
 @param size Size of the new image.
 @param topLeftRadius Top left radius.
 @param topRightRadius Top right radius.
 @param bottomRightRadius Bottom right radius.
 @param bottomLeftRadius Bottom left radius.
 @param borderWidth Border width.
 @param borderColor Border color. May be `nil`.
 @param foregroundColor Foreground color. May be `nil`.
 @param backgroundColor Background color. May be `nil`.
 
 @return An `UIImage` object.
 */
- (UIImage *)imageWithSize:(CGSize)size
            radiiAtTopLeft:(CGFloat)topLeftRadius
                  topRight:(CGFloat)topRightRadius
               bottomRight:(CGFloat)bottomRightRadius
                bottomLeft:(CGFloat)bottomLeftRadius
               borderWidth:(CGFloat)borderWidth
               borderColor:(UIColor *)borderColor
           foregroundColor:(UIColor *)foregroundColor
           backgroundColor:(UIColor *)backgroundColor;

#ifdef __IMAGEIO__

/// ------------------------
/// Creating Animated Images
/// ------------------------

/**
 Checks the number of source images in the supplied data object. You can use this method to test whether image data can be converted to animated image.
 
 @param data Data to check in.
 
 @return Number of source images.
 */
+ (NSUInteger)numberOfImagesInData:(NSData *)data;

/**
 Creates an animated image from supplied data, ie. GIF image.
 
 @param data Data to use.
 
 @return An `UIImage` object.
 */
+ (UIImage *)animatedImageWithData:(NSData *)data;

#endif

@end
