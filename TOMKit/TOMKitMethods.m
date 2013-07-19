//
//  TOMKitMethods.m
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

#import "TOMKitMethods.h"

CGRect CGRectForCenteredRectInRect(CGRect rectToCenter, CGRect containerRect) {
    CGRect rect;
    rect.origin.x = roundf(containerRect.origin.x + (containerRect.size.width-rectToCenter.size.width)/2.0f);
    rect.origin.y = roundf(containerRect.origin.y + (containerRect.size.height-rectToCenter.size.height)/2.0f);
    rect.size = rectToCenter.size;
    return rect;
}

CGRect CGRectByAddingPoint(CGRect rect, CGPoint point)
{
    CGRect newRect = rect;
    newRect.origin.x += point.x;
    newRect.origin.y += point.y;
    return newRect;
}

CGSize CGSizeThatFitsSize(CGSize originalSize, CGSize sizeToFit) {
	CGFloat destinationWidth, destinationHeight;
	if (originalSize.width > originalSize.height) {
		destinationWidth = sizeToFit.width;
		destinationHeight = originalSize.height * sizeToFit.width / originalSize.width;
	}
	else {
		destinationHeight = sizeToFit.height;
		destinationWidth = originalSize.width * sizeToFit.height / originalSize.height;
	}
    
	if (destinationHeight > sizeToFit.width) {
		destinationWidth = sizeToFit.width;
		destinationHeight = originalSize.height * sizeToFit.width / originalSize.width;
	}
	
    if (destinationHeight > sizeToFit.height) {
		destinationHeight = sizeToFit.height;
		destinationWidth = originalSize.width * sizeToFit.height / originalSize.height;
	}
    
    return CGSizeMake(destinationWidth, destinationHeight);
}

UIEdgeInsets UIEdgeInsetsMakeEqual(CGFloat inset) {
    return UIEdgeInsetsMake(inset, inset, inset, inset);
}

UIEdgeInsets UIEdgeInsetsMakeSimetric(CGFloat horizontal, CGFloat vertical) {
    return UIEdgeInsetsMake(vertical, horizontal, vertical, horizontal);
}