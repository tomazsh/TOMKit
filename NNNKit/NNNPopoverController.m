//
//  NNNPopoverController.m
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

#import "NNNPopoverController.h"

@interface NNNPopoverController () <UIPopoverControllerDelegate>

- (void)_initializePopoverController;

@end

@implementation NNNPopoverController

#pragma mark -
#pragma mark Initialization

- (id)init
{
    self = [super init];
    if (self) {
        [self _initializePopoverController];
    }
    return self;
}

- (id)initWithContentViewController:(UIViewController *)viewController
{
    self = [super initWithContentViewController:viewController];
    if (self) {
        [self _initializePopoverController];
    }
    return self;
}

- (void)_initializePopoverController
{
    if (!self.delegate) {
        self.delegate = self;
    }
}

#pragma mark -
#pragma mark UIPopoverController

- (id<UIPopoverControllerDelegate>)delegate
{
    return _externalDelegate;
}

- (void)setDelegate:(id<UIPopoverControllerDelegate>)delegate
{
    [super setDelegate:self];
    
    if (delegate != self) {
        _externalDelegate = delegate;
    } else {
        _externalDelegate = nil;
    }
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if (_didDismissBlock) {
        _didDismissBlock((NNNPopoverController *)popoverController);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(popoverControllerDidDismissPopover:)]) {
        [_externalDelegate popoverControllerDidDismissPopover:self];
    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    if (_shouldDismissBlock) {
        return _shouldDismissBlock((NNNPopoverController *)popoverController);
    }
    
    if ([_externalDelegate respondsToSelector:@selector(popoverControllerShouldDismissPopover:)]) {
        return [_externalDelegate popoverControllerShouldDismissPopover:self];
    }
    
    return YES;
}

@end
