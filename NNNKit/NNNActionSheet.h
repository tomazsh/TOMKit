//
//  NNNActionSheet.h
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

@class NNNActionSheet;

/**
 Action sheet block that takes action sheet as its sole parameter.
 */
typedef void (^NNNActionSheetBlock)(NNNActionSheet *);

/**
 Action sheet block that takes action sheet and button index as its parameters.
 */
typedef void (^NNNActionSheetButtonBlock)(NNNActionSheet *, NSInteger);

/**
 `NNNActionSheet` extends `UIActionSheet` with blocks.
 */
@interface NNNActionSheet : UIActionSheet {
    @private
    id<UIActionSheetDelegate> _externalDelegate;
    NSMutableDictionary *_buttonBlocks;
    NNNActionSheetBlock _willPresentBlock;
    NNNActionSheetBlock _didPresentBlock;
    NNNActionSheetBlock _cancelBlock;
    NNNActionSheetButtonBlock _willDismissBlock;
    NNNActionSheetButtonBlock _didDismissBlock;
}

///-----------------------------
/// @name Creating Action Sheets
///-----------------------------

/**
 Initializes the action sheet using the specified title.
 
 @param title A string to display in the title area of the action sheet. Pass nil if you do not want to display any text in the title area.
 
 @return A newly initialized action sheet.
 */
- (id)initWithTitle:(NSString *)title;

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
                          block:(NNNActionSheetButtonBlock)block;

/**
 Adds a destructive button to the action sheet with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current action sheet and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title
                                     block:(NNNActionSheetButtonBlock)block;

/**
 Adds a cancel button to the action sheet with a block to be executed on click.
 
 @param title The title of the new button.
 @param block The block to be executed on button click. This block takes two parameters: the current action sheet and index of the button.
 
 @return The index of the new button. Button indices start at 0 and increase in the order they are added.
 */
- (NSInteger)addCancelButtonWithTitle:(NSString *)title
                                block:(NNNActionSheetButtonBlock)block;

///---------------------------
/// @name Customizing Behavior
///---------------------------

/**
 Block to be executed before an action sheet is presented to the user. This block takes the current action sheet as its sole parameter.
 */
@property(copy, nonatomic) NNNActionSheetBlock willPresentBlock;

/**
 Block to be executed after an action sheet is presented to the user. This block takes the current action sheet as its sole parameter.
 */
@property(copy, nonatomic) NNNActionSheetBlock didPresentBlock;

/**
 Block to be executed before an action sheet is cancelled. This block takes the current action sheet as its sole parameter.
 */
@property(copy, nonatomic) NNNActionSheetBlock cancelBlock;

/**
 Block to be executed before an action sheet is dismissed. This block takes two parameters: the current action sheet and index of the button that dismissed it.
 */
@property(copy, nonatomic) NNNActionSheetButtonBlock willDismissBlock;

/**
 Block to be executed after an action sheet is dismissed. This block takes two parameters: the current action sheet and index of the button that dismissed it.
 */
@property(copy, nonatomic) NNNActionSheetButtonBlock didDismissBlock;

@end
