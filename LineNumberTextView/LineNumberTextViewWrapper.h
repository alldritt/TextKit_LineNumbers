//
//  LineNumberTextViewWrapper.h
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineNumberTextView.h"
#import "LineNumberLayoutManager.h"

// To use this from Swift, in the project settings,
// set the Objective-C Bridging Header to include the path of this file.
@interface LineNumberTextViewWrapper : UIView

@property (nonatomic) LineNumberTextView* textView;

/// Defaults to system font, 10pt. Convenience: just forwards to textView.
@property (nonatomic) IBInspectable UIFont *lineNumberFont;

/// Defaults to gray. Convenience: just forwards to textView.
@property (nonatomic) IBInspectable UIColor *lineNumberBackgroundColor;

/// Defaults to dark gray. Convenience: just forwards to textView.
@property (nonatomic) IBInspectable UIColor *lineNumberBorderColor;

/// Defaults to white. Convenience: just forwards to textView.
@property (nonatomic) IBInspectable UIColor *lineNumberTextColor;

@end
