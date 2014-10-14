//
//  ViewController.m
//  Pictowatch
//
//  Created by Anders Høst Kjærgaard on 30/08/12.
//  Copyright (c) 2012 ahkj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize dateFormatter;
@synthesize clockView;
@synthesize palette;

-(void)loadView{
    [super loadView];
    self.clockView = [[View alloc] initWithFrame:self.view.frame];
    self.clockView.delegate = self;
    [self.view addSubview:self.clockView];
//    [self.view addSubview:[[View alloc] initWithFrame:CGRectMake(0, (rect.size.height / 2) - (rect.size.width / 2), rect.size.width, (rect.size.height / 2) + (rect.size.width / 2))]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                    target:self
                                                  selector:@selector(pollTime)
                                                  userInfo:nil
                                                   repeats:YES];
    [self.clockView setNeedsDisplay];
    backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tgr setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tgr];
    
    UITapGestureRecognizer *tgr1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    tgr1.delegate = self;
    [self.view addGestureRecognizer:tgr1];
}

-(UIColor *)backgroundColor{
    return backgroundColor;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if(CGRectContainsPoint(self.palette.frame, [touch locationInView:self.view]))
        return NO;
    return YES;
}

-(void)tap:(id)sender{
    if(self.palette.frame.origin.y == 380){
        [UIView animateWithDuration:0.25 animations:^(){
            self.palette.frame = CGRectMake(0, 480, self.palette.frame.size.width, 100);
        }];
    }
    else{
        [UIView animateWithDuration:0.25 animations:^(){
            self.palette.frame = CGRectMake(0, 380, self.palette.frame.size.width, 100);
        }];
    }
}

-(void)tap1:(id)sender{
    if(self.palette.frame.origin.y == 380){
        [UIView animateWithDuration:0.25 animations:^(){
            self.palette.frame = CGRectMake(0, 480, self.palette.frame.size.width, 100);
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [pollingTimer invalidate];
    pollingTimer = nil;
}

- (void) pollTime
{
   NSLog(@"View hours: %d min: %d sec: %d", [self hour], [self minute], [self second]);
    int old = [self second];
    now = [[NSDate alloc] init];
    if(old != [self second])
        [self.clockView setNeedsDisplay];
}

-(int)milliseconds{
    [self.dateFormatter setDateFormat:@"SSS"];
    return [[self.dateFormatter stringFromDate:now] intValue];
}

-(int)second{
    [self.dateFormatter setDateFormat:@"ss"];
    return [[self.dateFormatter stringFromDate:now] intValue];
}

-(int)minute{
    [self.dateFormatter setDateFormat:@"mm"];
    return [[self.dateFormatter stringFromDate:now] intValue];
}

-(int)hour{
    [self.dateFormatter setDateFormat:@"hh"];
    return [[self.dateFormatter stringFromDate:now] intValue];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return  NO; //YES;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        self.clockView = [[View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
        self.clockView.delegate = self;
        [self.view addSubview:self.clockView];
        [self.clockView setNeedsDisplay];
    }
    else {
        self.clockView = [[View alloc] initWithFrame:self.view.frame];
        self.clockView.delegate = self;
        [self.view addSubview:self.clockView];
            [self.clockView setNeedsDisplay];
    }
}

-(NSDateFormatter *)dateFormatter{
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    return dateFormatter;
}

-(UIView *)palette{
    if(!palette){
        palette = [[UIView alloc] initWithFrame:CGRectMake(0, 480, self.view.frame.size.width, 150)];
        [palette setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:palette];
        [self addPaletteButtons];
    }
    return palette;
}

-(void)colorButtonTap:(UIButton *)sender{
    backgroundColor = [self buttonColorForTag:sender.tag];
    [self.clockView setNeedsDisplay];
}

-(void)addPaletteButtons{
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50 + (i * 40), 5, 35, 35);
        btn.tag = i;
        [btn setBackgroundColor:[self buttonColorForTag:i]];
        [btn addTarget:self action:@selector(colorButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.palette addSubview:btn];
    }
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(50 + i * 40, 45, 35, 35);
        btn.tag = i + 5;
        [btn setBackgroundColor:[self buttonColorForTag:i + 5]];
        [btn addTarget:self action:@selector(colorButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.palette addSubview:btn];
    }
}

-(UIColor *)buttonColorForTag:(int)tag{
    switch (tag) {
        case 0:
            return [UIColor greenColor];
            break;
        case 1:
            return [UIColor grayColor];
            break;
        case 2:
            return [UIColor yellowColor];
            break;
        case 3:
            return [UIColor darkGrayColor];
            break;
        case 4:
            return [UIColor purpleColor];
            break;
        case 5:
            return [UIColor magentaColor];
            break;
        case 6:
            return [UIColor blackColor];
            break;
        case 7:
            return [UIColor brownColor];
            break;
        case 8:
            return [UIColor cyanColor];
            break;
        case 9:
            return [UIColor orangeColor];
            break;
            
        default:
            return [UIColor blueColor];
            break;
    }
}



@end
