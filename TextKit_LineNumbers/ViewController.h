//
//  ViewController.h
//  TextKit_LineNumbers
//
//  Created by Mark Alldritt on 2013-10-11.
//  Copyright (c) 2013 Late Night Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineNumberTextViewWrapper.h"


@interface ViewController : UIViewController

@property (assign, nonatomic) IBOutlet LineNumberTextViewWrapper* myView;

@end
