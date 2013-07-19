//
//  TOMPopoverController.h
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

@class TOMPopoverController;

/**
 Popover controller block that takes popover controller as its sole parameter.
 */
typedef void (^TOMPopoverControllerBlock)(TOMPopoverController *);

/**
 Popover controller block that returns `YES` if popover controller should dismiss, otherwise `NO`, and takes popover controller as its sole parameter.
 */
typedef BOOL (^TOMPopoverControllerShouldDismissBlock)(TOMPopoverController *);

/**
 `TOMPopoverController` extends `UIPopoverController` with blocks.
 */
@interface TOMPopoverController : UIPopoverController

///---------------------------
/// @name Customizing Behavior
///---------------------------

/**
 Block to be executed after the popover controller is dismissed. This block takes the current popover controller as its sole parameter.
 */
@property (copy, nonatomic) TOMPopoverControllerBlock didDismissBlock;

/**
 Block to determine if the popover should be dismissed. This block returns `BOOL` value and takes the current popover controller as its sole parameter.
 */
@property (copy, nonatomic) TOMPopoverControllerShouldDismissBlock shouldDismissBlock;

@end
