//
//  LineNumberLayoutManager.m
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import "LineNumberLayoutManager.h"

@interface LineNumberLayoutManager ()

@property (nonatomic) NSUInteger lastParaLocation;
@property (nonatomic) NSUInteger lastParaNumber;

@end

@implementation LineNumberLayoutManager

- (instancetype)init  {
    self = [super init];
    [self initializeLineNumberLayoutManager];
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    [self initializeLineNumberLayoutManager];
    return self;
}

- (void)initializeLineNumberLayoutManager {
    _lineNumberFont = [UIFont systemFontOfSize:10.0];
    _lineNumberTextColor = [UIColor whiteColor];
}

- (NSUInteger) _paraNumberForRange:(NSRange) charRange {
    //  NSString does not provide a means of efficiently determining the paragraph number of a range of text.  This code
    //  attempts to optimize what would normally be a series linear searches by keeping track of the last paragraph number
    //  found and uses that as the starting point for next paragraph number search.  This works (mostly) because we
    //  are generally asked for continguous increasing sequences of paragraph numbers.  Also, this code is called in the
    //  course of drawing a pagefull of text, and so even when moving back, the number of paragraphs to search for is
    //  relativly low, even in really long bodies of text.
    //
    //  This all falls down when the user edits the text, and can potentially invalidate the cached paragraph number which
    //  causes a (potentially lengthy) search from the beginning of the string.
    
    if (charRange.location == self.lastParaLocation)
        return self.lastParaNumber;
    else if (charRange.location < self.lastParaLocation) {
        //  We need to look backwards from the last known paragraph for the new paragraph range.  This generally happens
        //  when the text in the UITextView scrolls downward, revaling paragraphs before/above the ones previously drawn.
        
        NSString* s = self.textStorage.string;
        __block NSUInteger paraNumber = self.lastParaNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(charRange.location, self.lastParaLocation - charRange.location)
                              options:NSStringEnumerationByParagraphs |
         NSStringEnumerationSubstringNotRequired |
         NSStringEnumerationReverse
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location <= charRange.location) {
                                   *stop = YES;
                               }
                               --paraNumber;
                           }];
        
        self.lastParaLocation = charRange.location;
        self.lastParaNumber = paraNumber;
        return paraNumber;
    }
    else {
        //  We need to look forward from the last known paragraph for the new paragraph range.  This generally happens
        //  when the text in the UITextView scrolls upwards, revealing paragraphs that follow the ones previously drawn.
        
        NSString* s = self.textStorage.string;
        __block NSUInteger paraNumber = self.lastParaNumber;
        
        [s enumerateSubstringsInRange:NSMakeRange(self.lastParaLocation, charRange.location - self.lastParaLocation)
                              options:NSStringEnumerationByParagraphs | NSStringEnumerationSubstringNotRequired
                           usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop){
                               if (enclosingRange.location >= charRange.location) {
                                   *stop = YES;
                               }
                               ++paraNumber;
                           }];
        
        self.lastParaLocation = charRange.location;
        self.lastParaNumber = paraNumber;
        return paraNumber;
    }
}

- (void)processEditingForTextStorage:(NSTextStorage *)textStorage edited:(NSTextStorageEditActions)editMask range:(NSRange)newCharRange changeInLength:(NSInteger)delta invalidatedRange:(NSRange)invalidatedCharRange {
    [super processEditingForTextStorage:textStorage edited:editMask range:newCharRange changeInLength:delta invalidatedRange:invalidatedCharRange];
    
    if (invalidatedCharRange.location < self.lastParaLocation) {
        //  When the backing store is edited ahead the cached paragraph location, invalidate the cache and force a complete
        //  recalculation.  We cannot be much smarter than this because we don't know how many paragraphs have been deleted
        //  since the text has already been removed from the backing store.
        
        self.lastParaLocation = 0;
        self.lastParaNumber = 0;
    }
}

- (void) drawBackgroundForGlyphRange:(NSRange)glyphsToShow atPoint:(CGPoint)origin {
    [super drawBackgroundForGlyphRange:glyphsToShow atPoint:origin];

    //  Draw line numbers.  Note that the background for line number gutter is drawn by the LineNumberTextView class.
    NSDictionary* atts = @{NSFontAttributeName : _lineNumberFont,
                           NSForegroundColorAttributeName : _lineNumberTextColor};
    __block CGRect gutterRect = CGRectZero;
    __block NSUInteger paraNumber;
    
    [self enumerateLineFragmentsForGlyphRange:glyphsToShow
                                   usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange glyphRange, BOOL *stop) {
                                       NSRange charRange = [self characterRangeForGlyphRange:glyphRange actualGlyphRange:nil];
                                       NSRange paraRange = [self.textStorage.string paragraphRangeForRange:charRange];
                                       
                                       //   Only draw line numbers for the paragraph's first line fragment.  Subsiquent fragments are wrapped portions of the paragraph and don't
                                       //   get the line number.
                                       if (charRange.location == paraRange.location) {
                                           gutterRect = CGRectOffset(CGRectMake(0, rect.origin.y, 40.0, rect.size.height), origin.x, origin.y);
                                           paraNumber = [self _paraNumberForRange:charRange];
                                           NSString* ln = [NSString stringWithFormat:@"%ld", (unsigned long) paraNumber + 1];
                                           CGSize size = [ln sizeWithAttributes:atts];
                                           
                                           [ln drawInRect:CGRectOffset(gutterRect, CGRectGetWidth(gutterRect) - 4 - size.width, (CGRectGetHeight(gutterRect) - size.height) / 2.0)
                                           withAttributes:atts];
                                       }
                                   }];
    
    //  Deal with the special case of an empty last line where enumerateLineFragmentsForGlyphRange has no line
    //  fragments to draw.
    if (NSMaxRange(glyphsToShow) > self.numberOfGlyphs) {
        NSString* ln = [NSString stringWithFormat:@"%ld", (unsigned long) paraNumber + 2];
        CGSize size = [ln sizeWithAttributes:atts];
        
        gutterRect = CGRectOffset(gutterRect, 0.0, CGRectGetHeight(gutterRect));
        [ln drawInRect:CGRectOffset(gutterRect, CGRectGetWidth(gutterRect) - 4 - size.width, (CGRectGetHeight(gutterRect) - size.height) / 2.0)
        withAttributes:atts];
    }
}

@end
