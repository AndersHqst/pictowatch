//
//  ViewController.h
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 30/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeDelegate.h"
#import "View.h"

@interface ViewController : UIViewController <TimeDelegate, UIGestureRecognizerDelegate>{
    UILabel *timerLabel;
    NSTimer *pollingTimer;
    NSDateFormatter *dateFormatter;
    NSDate *now;
    UIColor *backgroundColor;
//    View *view;
}

@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) View *clockView;
@property (nonatomic, strong) UIView *palette;

@end
