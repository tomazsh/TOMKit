//
//  UIColor+TOMKit.m
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

#import "UIColor+TOMKit.h"

@implementation UIColor (TOMKit)

#pragma mark -
#pragma mark Class Methods

+ (UIColor *)tom_colorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [self colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)tom_colorWithRGBAColor:(struct TOMRGBAColor)color
{
    return [UIColor colorWithRed:color.red/255.0f green:color.green/255.0f blue:color.blue/255.0f alpha:color.alpha];
}

+ (UIColor *)tom_colorWithHSBAColor:(struct TOMHSBAColor)color
{
    return [UIColor colorWithHue:color.hue/360.0f saturation:color.saturation brightness:color.brightness alpha:color.alpha];
}

+ (UIColor *)tom_colorWithHEXColor:(TOMHEXColor)color
{
    CGFloat red = ((CGFloat)((color & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((color & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(color & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
