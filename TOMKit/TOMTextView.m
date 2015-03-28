//
//  TOMTextView.m
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

#import "TOMTextView.h"

@interface TOMTextView ()

@property (nonatomic) BOOL shouldDrawPlaceholder;

@end

@implementation TOMTextView

#pragma mark -
#pragma mark Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTOMTextView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initTOMTextView];
    }
    return self;
}

- (void)initTOMTextView {
    _autogrow = NO;
    _shouldDrawPlaceholder = NO;
    self.contentMode = UIViewContentModeRedraw;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -
#pragma mark Properties

- (void)setText:(NSString *)text {
	[super setText:text];
    [self updateShouldDrawPlaceholder];
    [self resizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if ([_placeholder isEqualToString:placeholder]) {
        return;
    }
    
    [self willChangeValueForKey:@"placeholder"];
    _placeholder = [placeholder copy];
    [self didChangeValueForKey:@"placeholder"];
    
    [self updateShouldDrawPlaceholder];
    [self resizeToFit];
}

- (UIFont *)placeholderFont {
    if (!_placeholderFont) {
        _placeholderFont = self.font;
    }
    return _placeholderFont;
}

- (UIColor *)placeholderColor {
    if (!_placeholderColor) {
        _placeholderColor = [UIColor lightGrayColor];
    }
    return _placeholderColor;
}

- (void)setAutogrow:(BOOL)autogrow {
    if (_autogrow == autogrow) {
        return;
    }
    
    [self willChangeValueForKey:@"autogrow"];
    _autogrow = autogrow;
    [self didChangeValueForKey:@"autogrow"];
    
    [self resizeToFit];
}

#pragma mark -
#pragma mark UIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
	if (self.shouldDrawPlaceholder) {
        rect = UIEdgeInsetsInsetRect(rect, self.contentInset);
        
        // Use 8.0 point vertical offset to match UITextField placeholder.
        if (self.contentInset.left == 0.0f) {
			rect.origin.x += 8.0f;
		}
		rect.origin.y += 8.0f;
        
		[self.placeholderColor set];
        [self.placeholder drawAtPoint:rect.origin withAttributes:@{ NSFontAttributeName : self.placeholderFont }];
	}
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (!self.autogrow) {
        return [super sizeThatFits:size];
    }
    
    CGSize textSize = [super sizeThatFits:size];
    
    // Check if size is smaller than desired and adjust it accordingly.
    if ([self.delegate respondsToSelector:@selector(minimumAutogrowSizeForTextView:)]) {
        CGSize minimumSize = [self.delegate minimumAutogrowSizeForTextView:self];
        textSize.height = MAX(textSize.height, minimumSize.height);
    }
    
    // Check if size is larger than desired and adjust it accordingly.
    if ([self.delegate respondsToSelector:@selector(maximumAutogrowSizeForTextView:)]) {
        CGSize maximumSize = [self.delegate maximumAutogrowSizeForTextView:self];
        textSize.height = MIN(textSize.height, maximumSize.height);
    }
	 
    return textSize;
}

#pragma mark -
#pragma mark Autogrowing

- (void)textDidChange:(NSNotification *)notification {
	[self updateShouldDrawPlaceholder];
    if (self.autogrow) {
        [self resizeToFit];
    }
}

- (void)updateShouldDrawPlaceholder {
	BOOL prev = self.shouldDrawPlaceholder;
	self.shouldDrawPlaceholder = [self.placeholder length] && ![self.text length];
	if (prev != self.shouldDrawPlaceholder) {
		[self setNeedsDisplay];
	}
}

- (void)resizeToFit {
    CGSize sizeThatFits = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = sizeThatFits.height;
    
    if (CGRectEqualToRect(self.frame, frame)) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(textView:willAutogrowToSize:)]) {
        [self.delegate textView:self willAutogrowToSize:frame.size];
    }
    
    self.frame = frame;
    
    if ([self.delegate respondsToSelector:@selector(textView:didAutogrowToSize:)]) {
        [self.delegate textView:self didAutogrowToSize:frame.size];
    }
}

@end
