//
//  UIScreen+TOMKit.m
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

#import "UIScreen+TOMKit.h"

@implementation UIScreen (TOMKit)

#pragma mark -
#pragma mark Class Methods

+ (UIInterfaceOrientation)deviceOrientation
{
    return [[UIApplication sharedApplication] statusBarOrientation];
}

+ (BOOL)isMainScreenRetina
{
    static BOOL IsRetina;
    static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		IsRetina = ([[[self class] mainScreen] isRetina]);
	});
	return IsRetina;
}

#pragma mark -
#pragma mark Instance Methods

- (BOOL)isRetina
{
    return [self respondsToSelector:@selector(scale)] && [self scale] == 2;
}

@end
