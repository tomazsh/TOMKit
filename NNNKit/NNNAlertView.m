//
//  NNNAlertView.m
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

#import "NNNAlertView.h"

@interface NNNAlertView () <UIAlertViewDelegate>

- (void)_initializeAlertView;

@end

@implementation NNNAlertView

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initializeAlertView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initializeAlertView];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle cancelBlock:(NNNAlertViewButtonBlock)cancelBlock
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        [self _initializeAlertView];
        if (cancelBlock) {
            [_buttonBlocks setObject:cancelBlock forKey:[NSNumber numberWithInteger:self.cancelButtonIndex]];
        }
    }
    return self;
}

- (void)_initializeAlertView
{
    if (!self.delegate) {
        self.delegate = self;
    }
    _buttonBlocks = [[NSMutableDictionary alloc] init];
}

#pragma mark -
#pragma mark Instance Methods

- (NSInteger)addButtonWithTitle:(NSString *)title block:(NNNAlertViewButtonBlock)block
{
    NSInteger idx = [self addButtonWithTitle:title];
    if (block) {
        [_buttonBlocks setObject:block forKey:[NSNumber numberWithInteger:idx]];
    }
    return idx;
}

- (NSInteger)setCancelButtonWithTitle:(NSString *)title block:(NNNAlertViewButtonBlock)block
{
    [_buttonBlocks removeObjectForKey:[NSNumber numberWithInteger:self.cancelButtonIndex]];
    NSInteger idx = [self addButtonWithTitle:title block:block];
    self.cancelButtonIndex = idx;
    return idx;
}

#pragma mark -
#pragma mark UIActionSheet

- (id<UIAlertViewDelegate>)delegate
{
    return _externalDelegate;
}

- (void)setDelegate:(id<UIAlertViewDelegate>)delegate
{
    [super setDelegate:self];
    
    if (delegate != self) {
        _externalDelegate = delegate;
    } else {
        _externalDelegate = nil;
    }
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NNNAlertViewButtonBlock block = [_buttonBlocks objectForKey:[NSNumber numberWithInteger:buttonIndex]];
    if (block) {
        block((NNNAlertView *)alertView, buttonIndex);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_externalDelegate alertView:alertView clickedButtonAtIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_didDismissBlock) {
        _didDismissBlock((NNNAlertView *)alertView, buttonIndex);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [_externalDelegate alertView:alertView didDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_willDismissBlock) {
        _willDismissBlock((NNNAlertView *)alertView, buttonIndex);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [_externalDelegate alertView:alertView willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (_cancelBlock) {
        _cancelBlock((NNNAlertView *)alertView);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(alertViewCancel:)]) {
        [_externalDelegate alertViewCancel:alertView];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (_shouldEnableFirstOtherButtonBlock) {
        _shouldEnableFirstOtherButtonBlock((NNNAlertView *)alertView);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
        return [_externalDelegate alertViewShouldEnableFirstOtherButton:alertView];
    }
    return YES;
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (_didPresentBlock) {
        _didPresentBlock((NNNAlertView *)alertView);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(didPresentAlertView:)]) {
        [_externalDelegate didPresentAlertView:alertView];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (_willPresentBlock) {
        _willPresentBlock((NNNAlertView *)alertView);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [_externalDelegate willPresentAlertView:alertView];
    }
}

@end
