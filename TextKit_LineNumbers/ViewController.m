//
//  ViewController.m
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Account for the transparent iOS7 sstatus bar
    NSUInteger navBarHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    UIEdgeInsets insets = self.myView.textView.contentInset;
    insets.top += navBarHeight;
    self.myView.textView.contentInset = insets;

    //  Display some sample text to start with
    NSAttributedString* ats = [[NSAttributedString alloc] initWithFileURL:[NSBundle.mainBundle URLForResource:@"Sample" withExtension:@"rtf"]
                                                                  options:nil
                                                       documentAttributes:nil
                                                                    error:nil];
    self.myView.textView.attributedText = ats;
}

@end
