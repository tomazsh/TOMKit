//
//  TOMKitMetrics.h
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

#ifndef UIViewAutoresizingFlexibleMargins
#define UIViewAutoresizingFlexibleMargins (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin)
#endif

#ifndef UIViewAutoresizingFlexibleDimensions
#define UIViewAutoresizingFlexibleDimensions (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
#endif

#ifndef TOMRGBAColor
struct TOMRGBAColor {
    CGFloat red; // Valid value is between 0.0f and 255.0f.
    CGFloat green; // Valid value is between 0.0f and 255.0f.
    CGFloat blue; // Valid value is between 0.0f and 255.0f.
    CGFloat alpha; // Valid value is between 0.0f and 1.0f.
};
#endif

#ifndef TOMHSBAColor
struct TOMHSBAColor {
    CGFloat hue; // Valid values are from 0.0f to 360.0f.
    CGFloat saturation; // Valid value is between 0.0f and 1.0f.
    CGFloat brightness; // Valid value is between 0.0f and 1.0f.
    CGFloat alpha;
};
#endif

#ifndef TOMHEXColor
typedef NSUInteger TOMHEXColor;
#endif

#define TOM_PHONE UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone
#define TOM_PAD   UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad