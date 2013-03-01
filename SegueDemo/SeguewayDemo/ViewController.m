//
//  ViewController.m
//  SeguewayDemo
//
//  Created by Michael Shafae on 2/26/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

- (IBAction)buttonPressed:(UIButton *)sender {
  NSString* msg = self.myTextField.text;
  if ([msg length] == 0) {
    msg = @"World";
  }
  NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", msg];
  self.myLabel.text = greeting;
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
}

@end
