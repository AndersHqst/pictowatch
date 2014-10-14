//
//  TimeDelegate.h
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 30/08/12.
//  Copyright (c) 2012 ahkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeDelegate <NSObject>
-(int)hour;
-(int)minute;
-(int)second;
-(int)milliseconds;
-(UIColor *)backgroundColor;
@end
