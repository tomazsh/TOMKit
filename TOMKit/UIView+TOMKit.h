//
//  UIView+TOMKit.h
//  Scraps
//
//  Created by Tomaz Nedeljko on 14/1/13.
//  Copyright (c) 2015 Tomaz Nedeljko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 The `UIView(TOMKit)` protocol extends `UIView`.
 */
@interface UIView (TOMKit)

#ifdef QUARTZCORE_H

/// ---------------------------------
/// @name Rendering Images from Views
/// ---------------------------------

/**
 Renders an image from current layer on the main queue.
 
 @return A `UIImage` instance.
 */
- (UIImage *)tom_imageByRenderingLayer;

/**
 Renders an image from a frame in the current layer bounds with an opaque or transparent background on the main queue.
 
 @param frame Frame to render.
 @param opaque `YES` is the layer should be rendered with opaque background; otherwise `NO`.
 
 @return A `UIImage` instance.
 */
- (UIImage *)tom_imageByRenderingLayerFrame:(CGRect)frame
                                     opaque:(BOOL)opaque;

/**
 Renders an image from current layer in background on the global queue.
 
 @param completion Block to be executed when rendering is complete. This block has no return type and takes the returned image as its sole parameter.
 */
- (void)tom_imageByRenderingLayerCompletion:(void (^)(UIImage *))completion;

#endif

@end
