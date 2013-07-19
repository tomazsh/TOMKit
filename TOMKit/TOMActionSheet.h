//
//  TOMActionSheet.h
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

@class TOMActionSheet;

/**
 Action sheet block that takes action sheet as its sole parameter.
 */
typedef void (^TOMActionSheetBlock)(TOMActionSheet *actionSheet);

/**
 Action sheet block that takes action sheet and button index as its parameters.
 */
typedef void (^TOMActionSheetButtonBlock)(TOMActionSheet *actionSheet, NSInteger buttonIndex);

/**
 `TOMActionSheet` extends `UIActionSheet` with blocks.
 */
@interface TOMActionSheet : UIActionSheet

///-----------------------------
/// @name Creating Action Sheets
///-----------------------------

/**
 Initializes the action sheet using the specified title.
 
 @param title A string to display in the title area of the action sheet. Pass nil if you do not want to display any text in the title area.
 
 @return A newly initialized action sheet.
 */
- (instancetype)initWithTitle:(NSString *)title;

///--------------------------
/// @name Configuring Buttons
///--------------------------

/**
 Adds a custom button to the action sheet with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current action sheet and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addButtonWithTitle:(NSString *)title
                          block:(TOMActionSheetButtonBlock)block;

/**
 Adds a destructive button to the action sheet with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current action sheet and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title
                                     block:(TOMActionSheetButtonBlock)block;

/**
 Adds a cancel button to the action sheet with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current action sheet and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addCancelButtonWithTitle:(NSString *)title
                                block:(TOMActionSheetButtonBlock)block;

///---------------------------
/// @name Customizing Behavior
///---------------------------

/**
 Block to be executed before an action sheet is presented to the user. This block takes the current action sheet as its sole parameter.
 */
@property (copy, nonatomic) TOMActionSheetBlock willPresentBlock;

/**
 Block to be executed after an action sheet is presented to the user. This block takes the current action sheet as its sole parameter.
 */
@property (copy, nonatomic) TOMActionSheetBlock didPresentBlock;

/**
 Block to be executed before an action sheet is cancelled. This block takes the current action sheet as its sole parameter.
 */
@property (copy, nonatomic) TOMActionSheetBlock cancelBlock;

/**
 Block to be executed before an action sheet is dismissed. This block takes two parameters: the current action sheet and index of the button that dismissed it.
 */
@property (copy, nonatomic) TOMActionSheetButtonBlock willDismissBlock;

/**
 Block to be executed after an action sheet is dismissed. This block takes two parameters: the current action sheet and index of the button that dismissed it.
 */
@property (copy, nonatomic) TOMActionSheetButtonBlock didDismissBlock;

@end
