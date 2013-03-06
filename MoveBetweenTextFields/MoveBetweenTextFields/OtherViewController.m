//
//  ViewController.m
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 2/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "OtherViewController.h"
#import "UITextField+NextTextFieldProperty.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

@synthesize tfA;
@synthesize tfB;

- (void)touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event
{
  NSLog( @"resigning first respond for inputTextField; Touch event!" );
  if ( ! [self isFirstResponder]) {
    if ([self.tfA isFirstResponder]) {
      [self.tfA resignFirstResponder];
    }
    if ([self.tfB isFirstResponder]) {
      [self.tfB resignFirstResponder];
    }
  }
}

- (void)nextOrPreviousClicked: (UIBarButtonItem*) sender
{
  UITextField* next = self.activeTF.nextTextField;
  if (next) {
    [next becomeFirstResponder];
  }
}

- (void) doneClicked: (UIBarButtonItem*) sender
{
  NSLog( @"done pressed resigning first respond for inputTextField; Touch event!" );
  [self.activeTF resignFirstResponder];
}


- (BOOL)textFieldShouldBeginEditing: (UITextField *) textField
{
  self.activeTF = textField;
  NSLog(@"Right before");

  UIToolbar *toolbar = [[UIToolbar alloc] init];
  [toolbar sizeToFit];
  
  UIBarButtonItem *prevButton = [[UIBarButtonItem alloc]
                                 initWithTitle: @"Previous"
                                 style: UIBarButtonItemStyleDone
                                 target: self
                                 action:@selector(nextOrPreviousClicked:)];
  
  UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                 initWithTitle: @"Next"
                                 style: UIBarButtonItemStyleDone
                                 target: self
                                 action:@selector(nextOrPreviousClicked:)];
  
  UIBarButtonItem *flexButton = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                 target: self
                                 action: nil];
  
  UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                target: self
                                action: @selector(doneClicked:)];
  
  NSArray* itemsArray = @[prevButton, nextButton, flexButton, doneButton];
  
  [toolbar setItems: itemsArray];
  
  [textField setInputAccessoryView: toolbar];

  return YES;
}

- (void)handleSwipeRightFrom:(UIGestureRecognizer*)recognizer {
  NSLog(@"Wow! That's a swipe to the right!");
  NSLog(@"from OVC to VC");
  [self performSegueWithIdentifier:@"fromOVCtoVC" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.tfA.nextTextField = self.tfB;
  self.tfB.nextTextField = self.tfA;
	// Do any additional setup after loading the view, typically from a nib.
  UISwipeGestureRecognizer* swipeRightGestureRecognizer =
  [[UISwipeGestureRecognizer alloc] initWithTarget: self
                                    action: @selector(handleSwipeRightFrom:)];
  swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
  [self.view addGestureRecognizer: swipeRightGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
