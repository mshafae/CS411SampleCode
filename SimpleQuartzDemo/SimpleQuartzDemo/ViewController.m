//
//  ViewController.m
//  SimpleQuartzDemo
//
//  Created by Michael Shafae on 3/7/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
  unsigned int x = ((MyQuartzView*)self.view).demo;
  ((MyQuartzView*)self.view).demo = (x + 1) % NUM_DEMOS;
  NSLog( @"Touch event! %d", ((MyQuartzView*)self.view).demo);

  [self.view setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
