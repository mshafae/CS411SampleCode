//
//  MSViewController.m
//  RunLoopYieldDemo
//
//  Created by Michael Shafae on 3/14/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

@synthesize yield;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.yield = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goPressed:(UIButton *)sender {
  while ([self.label.text integerValue] < 100) {
    self.label.text = [NSString stringWithFormat: @"%d", [self.label.text integerValue]+1];
    if (self.yield) {
      [[NSRunLoop currentRunLoop] runUntilDate: [NSDate date]];
    }
  }
}

- (IBAction)resetPressed:(UIButton *)sender {
  self.label.text = @"0";
}

- (IBAction)yieldPressed:(UIButton *)sender {
  self.yield = !self.yield;
 }
@end
