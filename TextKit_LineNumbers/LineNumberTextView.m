//
//  LineNumberTextView.m
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import "LineNumberTextView.h"
#import "LineNumberLayoutManager.h"


@implementation LineNumberTextView

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(NO, @"initWithCoder not allowed");
    return self;
}

- (id)initWithFrame:(CGRect) frame {
    NSTextStorage* ts = [[NSTextStorage alloc] init];
    LineNumberLayoutManager* lm = [[LineNumberLayoutManager alloc] init];
    NSTextContainer* tc = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    //  Wrap text to the text view's frame
    tc.widthTracksTextView = YES;

    //  Exclude the line number gutter from the display area available for text display.
    tc.exclusionPaths = @[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, 40.0, CGFLOAT_MAX)]];

    [lm addTextContainer:tc];
    [ts addLayoutManager:lm];

    if ((self = [super initWithFrame:frame textContainer:tc])) {
        self.contentMode = UIViewContentModeRedraw;
        //self.typingAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0],
        //                          NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]};
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = self.bounds;
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillRect(context, CGRectMake(bounds.origin.x, bounds.origin.y, kLineNumberGutterWidth, bounds.size.height));
    
    CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextStrokeRect(context, CGRectMake(bounds.origin.x + 39.5, bounds.origin.y, 0.5, CGRectGetHeight(bounds)));
    
    [super drawRect:rect];
}

@end
