//
//  View.h
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 30/08/12.
//  Copyright (c) 2012 ahkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeDelegate.h"

@interface View : UIView
@property (nonatomic) id<TimeDelegate> delegate;
@end
