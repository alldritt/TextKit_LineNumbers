//
//  LineNumberTextViewWrapper.m
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import "LineNumberTextViewWrapper.h"

//
//  This class is here so that we can use a storyboard.  This is required because we must use the UITextView's
//  -[initWithFrame:textContainer:] initializer in order to substitute our own layout manager.  This cannot be done
//  using UITextView's -[initWithCoder:] initializer which is the one used whe views are created from a storyboard.
//
//  This class also

@implementation LineNumberTextViewWrapper

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.textView = [[LineNumberTextView alloc] initWithFrame:self.bounds];
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.textView];
    }
    return self;
}

- (UIFont *)lineNumberFont {
    return self.textView.lineNumberFont;
}

- (void)setLineNumberFont:(UIFont *)lineNumberFont {
    self.textView.lineNumberFont = lineNumberFont;
}

- (UIColor *)lineNumberBackgroundColor {
    return self.textView.lineNumberBackgroundColor;
}

- (void)setLineNumberBackgroundColor:(UIColor *)lineNumberBackgroundColor {
    self.textView.lineNumberBackgroundColor = lineNumberBackgroundColor;
}

- (UIColor *)lineNumberBorderColor {
    return self.textView.lineNumberBorderColor;
}

- (void)setLineNumberBorderColor:(UIColor *)lineNumberBorderColor {
    self.textView.lineNumberBorderColor = lineNumberBorderColor;
}

- (UIColor *)lineNumberTextColor {
    return self.textView.lineNumberTextColor;
}

- (void)setLineNumberTextColor:(UIColor *)lineNumberTextColor {
    self.textView.lineNumberTextColor = lineNumberTextColor;
}

@end
