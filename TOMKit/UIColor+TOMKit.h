//
//  UIColor+TOMKit.h
//  TOMKit
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
 The `UIColor(TOMKit)` protocol extends `UIColor`.
 */
@interface UIColor (TOMKit)

/// -----------------------------------------------------
/// @name Creating a UIColor Object from Component Values
/// -----------------------------------------------------

/**
 Creates and returns a color object using the specified opacity and RGB component integer values.
 
 @param red The red component of the color object, specified as a value from 0 to 255.
 @param green The green component of the color object, specified as a value from 0 to 255.
 @param blue The blue component of the color object, specified as a value from 0 to 255.

 @return An `UIColor` value.
 */
+ (UIColor *)colorWithIntRed:(NSUInteger)red
                       green:(NSUInteger)green
                        blue:(NSUInteger)blue
                       alpha:(CGFloat)alpha;

/// -------------------
/// @name System Colors
/// -------------------

/**
 Returns the system color used for displaying text in table view cells labels for detail text.
 
 @return An `UIColor` value.
 */
+ (UIColor *)tableViewDetailLabelColor;

@end
