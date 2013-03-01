//
//  ViewController.m
//  CallAndRespond
//
//  Created by Michael Shafae on 2/19/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myLabel = _myLabel;
@synthesize myTextField = _myTextField;

-(IBAction)buttonPressed:(UIButton*)sender
{
  self.myLabel.text = [NSString stringWithFormat: @"%d", self.myLabel.text.intValue + 1];
  NSLog(@"Hey! %@", self.myLabel.text);
  NSLog(@"My Text Field: %@", self.myTextField.text);
  //NSLog(@"Hey! %@", [[self myLabel] text]);
  //sNSLog(@"Hey! %@", [_myLabel text]);

}

- (BOOL) textFieldShouldReturn:(UITextField*) sender
{
  NSLog(@"resigning first responder; putting away the keyboard.");
  [sender resignFirstResponder];
  return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSLog( @"resigning first respond for inputTextField; Touch event!" );
  [self.myTextField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  //self.myTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
