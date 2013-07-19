//
//  UIView+TOMKit.h
//  Scraps
//
//  Created by Tomaz Nedeljko on 14/1/13.
//  Copyright (c) 2013 Tomaz Nedeljko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

- (UIImage *)tom_imageByRenderingLayerFrame:(CGRect)frame
                                     opaque:(BOOL)opaque;

/**
 Renders an image from current layer in background on the global queue.
 
 @param completion Block to be executed when rendering is complete. This block has no return type and takes the returned image as its sole parameter.
 */
- (void)tom_imageByRenderingLayerCompletion:(void (^)(UIImage *))completion;

#endif

@end
