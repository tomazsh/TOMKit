//
//  TOMActionSheet.m
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

#import "TOMActionSheet.h"

@interface TOMActionSheet () <UIActionSheetDelegate>

- (void)_initializeActionSheet;

@end

@implementation TOMActionSheet

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initializeActionSheet];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initializeActionSheet];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    self = [super initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        [self _initializeActionSheet];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:title delegate:delegate cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        [self _initializeActionSheet];
    }
    return self;
}

- (void)_initializeActionSheet
{
    if (!self.delegate) {
        self.delegate = self;
    }
    _buttonBlocks = [[NSMutableDictionary alloc] init];
}

#pragma mark -
#pragma mark Instance Methods

- (NSInteger)addButtonWithTitle:(NSString *)title block:(TOMActionSheetButtonBlock)block
{
    NSInteger idx = [self addButtonWithTitle:title];
    if (block) {
        [_buttonBlocks setObject:block forKey:[NSNumber numberWithInteger:idx]];
    }
    return idx;
}

- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title block:(TOMActionSheetButtonBlock)block
{
    [_buttonBlocks removeObjectForKey:[NSNumber numberWithInteger:self.destructiveButtonIndex]];
    NSInteger idx = [self addButtonWithTitle:title block:block];
    self.destructiveButtonIndex = idx;
    return idx;
}

- (NSInteger)addCancelButtonWithTitle:(NSString *)title block:(TOMActionSheetButtonBlock)block
{
    [_buttonBlocks removeObjectForKey:[NSNumber numberWithInteger:self.cancelButtonIndex]];
    NSInteger idx = [self addButtonWithTitle:title block:block];
    self.cancelButtonIndex = idx;
    return idx;
}


#pragma mark -
#pragma mark UIActionSheet

- (id<UIActionSheetDelegate>)delegate
{
    return _externalDelegate;
}

- (void)setDelegate:(id<UIActionSheetDelegate>)delegate
{
    [super setDelegate:self];
    
    if (delegate != self) {
        _externalDelegate = delegate;
    } else {
        _externalDelegate = nil;
    }
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TOMActionSheetBlock block = [_buttonBlocks objectForKey:[NSNumber numberWithInteger:buttonIndex]];
    if (block) {
        block((TOMActionSheet *)actionSheet);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_externalDelegate actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (_willPresentBlock) {
        _willPresentBlock((TOMActionSheet *)actionSheet);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [_externalDelegate willPresentActionSheet:actionSheet];
    }
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet
{
    if (_didPresentBlock) {
        _didPresentBlock((TOMActionSheet *)actionSheet);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(didPresentActionSheet:)]) {
        [_externalDelegate didPresentActionSheet:actionSheet];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_willDismissBlock) {
        _willDismissBlock((TOMActionSheet *)actionSheet, buttonIndex);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [_externalDelegate actionSheet:actionSheet willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_didDismissBlock) {
        _didDismissBlock((TOMActionSheet *)actionSheet, buttonIndex);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        [_externalDelegate actionSheet:actionSheet didDismissWithButtonIndex:buttonIndex];
    }
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if (_cancelBlock) {
        _cancelBlock((TOMActionSheet *)actionSheet);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [_externalDelegate actionSheetCancel:actionSheet];
    }
}


@end
