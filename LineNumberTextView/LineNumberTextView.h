//
//  LineNumberTextView.h
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kLineNumberGutterWidth      40.0

@interface LineNumberTextView : UITextView

/// Defaults to system font, 10pt.
@property (nonatomic) UIFont *lineNumberFont;

/// Defaults to gray.
@property (nonatomic) UIColor *lineNumberBackgroundColor;

/// Defaults to dark gray.
@property (nonatomic) UIColor *lineNumberBorderColor;

/// Defaults to white.
@property (nonatomic) UIColor *lineNumberTextColor;

- (id)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
