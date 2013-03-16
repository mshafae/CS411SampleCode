//
//  ViewController.m
//  SeguewayDemo
//
//  Created by Michael Shafae on 2/26/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize model;
@synthesize myTextField;

-(MyModel*) model
{
  if(model == nil){
    model = [[MyModel alloc] init];
  }
  NSLog(@"model %p", model);
  return model;
}

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
  NSLog( @"resigning first respond for myTextField; Touch event!" );
  if ( ! [self isFirstResponder]) {
    if ([self.myTextField isFirstResponder]) {
      [self.myTextField resignFirstResponder];
    }
  }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  NSLog(@"VC: view did load");
  NSLog(@"%@  - %@", self.myTextField.text, self.model.text );
  if ([self.model.text  compare: @""] != NSOrderedSame) {
    self.myTextField.text = self.model.text;
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  if (theTextField == self.myTextField) {
    [theTextField resignFirstResponder];
  }
  return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSLog(@"prepareForSegue: %@", segue.identifier);
  self.model.text = self.myTextField.text;
  ((OtherViewController*)(segue.destinationViewController)).visitingModel = self.model;
}

@end
