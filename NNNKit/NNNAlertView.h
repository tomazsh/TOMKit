//
//  NNNAlertView.h
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

@class NNNAlertView;

/**
 Alert view block that takes alrt view as its sole parameter.
 */
typedef void (^NNNAlertViewBlock)(NNNAlertView *);

/**
 Alert view block that takes alert view and button index as its parameters.
 */
typedef void (^NNNAlertViewButtonBlock)(NNNAlertView *, NSInteger);

/**
 Alert view block that returns `YES` if alert view should enable first other button, `NO` otherwise, and takes alert view as its sole parameter.
 */
typedef BOOL (^NNNAlertViewShouldEnableFirstOtherButtonBlock)(NNNAlertView *);

/**
 `NNNAlertView` extends `UIAlertView` with blocks.
 */
@interface NNNAlertView : UIAlertView {
    @private
    id<UIAlertViewDelegate> _externalDelegate;
    NSMutableDictionary *_buttonBlocks;
    NNNAlertViewBlock _willPresentBlock;
    NNNAlertViewBlock _didPresentBlock;
    NNNAlertViewBlock _cancelBlock;
    NNNAlertViewShouldEnableFirstOtherButtonBlock _shouldEnableFirstOtherButtonBlock;
    NNNAlertViewButtonBlock _willDismissBlock;
    NNNAlertViewButtonBlock _didDismissBlock;
}

///---------------------------
/// @name Creating Alert Views
///---------------------------

/**
 Convenience method for initializing an alert view.
 
 @param title The string that appears in the receiver’s title bar.
 @param message Descriptive text that provides more details than the title.
 @param cancelButtonTitle The title of the cancel button or nil` if there is no cancel button.
 @param cancelBlock The block to be executed on cancel button click. This block takes two parameters: the current alert view and index of the cancel button.
 
 @return A newly initialized action sheet.
 */
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        cancelBlock:(NNNAlertViewButtonBlock)cancelBlock;

///--------------------------
/// @name Configuring Buttons
///--------------------------

/**
 Adds a custom button to the alert view with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current alert view and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title
                          block:(NNNAlertViewButtonBlock)block;

- (NSInteger)setCancelButtonWithTitle:(NSString *)title
                                block:(NNNAlertViewButtonBlock)block;

///---------------------------
/// @name Customizing Behavior
///---------------------------

/**
 Block to be executed before an alert view is presented to the user. This block takes the current alert view as its sole parameter.
 */
@property(copy, nonatomic) NNNAlertViewBlock willPresentBlock;

/**
 Block to be executed after an alert view is presented to the user. This block takes the current alert view as its sole parameter.
 */
@property(copy, nonatomic) NNNAlertViewBlock didPresentBlock;

/**
 Block to be executed before an alert view is cancelled. This block takes the current alert view as its sole parameter.
 */
@property(copy, nonatomic) NNNAlertViewBlock cancelBlock;

/**
 Block to determine whether the first non-cancel button on the alert should be enabled. This block returns `BOOL` value and takes the current alert view as its sole parameter.
 */
@property(copy, nonatomic) NNNAlertViewShouldEnableFirstOtherButtonBlock shouldEnableFirstOtherButtonBlock;

/**
 Block to be executed before an alert view is dismissed. This block takes two parameters: the current alert view and index of the button that dismissed it.
 */
@property(copy, nonatomic) NNNAlertViewButtonBlock willDismissBlock;

/**
 Block to be executed after an alert view is dismissed. This block takes two parameters: the current alert view and index of the button that dismissed it.
 */
@property(copy, nonatomic) NNNAlertViewButtonBlock didDismissBlock;

@end
