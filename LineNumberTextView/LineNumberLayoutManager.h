//
//  LineNumberLayoutManager.h
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineNumberLayoutManager : NSLayoutManager
/// Defaults to system font, 10pt.
@property (nonatomic) UIFont *lineNumberFont;

/// Defaults to white.
@property (nonatomic) UIColor *lineNumberTextColor;

@end
