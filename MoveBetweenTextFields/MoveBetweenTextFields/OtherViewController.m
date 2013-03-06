//
//  ViewController.m
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 2/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "OtherViewController.h"

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

- (void)nextClicked: (UIBarButtonItem*) sender
{
  NSInteger tag = sender.tag;
  if( tag == 0 ){
    [tfA becomeFirstResponder];
  }else{
    [tfB becomeFirstResponder];
  }
}

- (void)previousClicked: (UIBarButtonItem*) sender
{
  NSInteger tag = sender.tag;
  if( tag == 0 ){
    [tfA becomeFirstResponder];
  }else{
    [tfB becomeFirstResponder];
  }
}

- (void) doneClicked: (UIBarButtonItem*) sender
{
  NSLog( @"done pressed resigning first respond for inputTextField; Touch event!" );
  NSInteger tag = sender.tag;
  if (tag == 0){
    [self.tfA resignFirstResponder];
  }else{
    [self.tfB resignFirstResponder];
  }
}

#define _ABS( x ) ((x) < (0) ? (-x) : (x))
#define NUM_TEXTFIELDS 2

- (BOOL)textFieldShouldBeginEditing: (UITextField *) textField
{
  NSLog(@"Right before");
  NSUInteger tag = textField.tag;
  NSUInteger nextTag = (tag + 1) % NUM_TEXTFIELDS;
  NSUInteger prevTag = (_ABS((tag - 1))) % NUM_TEXTFIELDS;

  UIToolbar *toolbar = [[UIToolbar alloc] init];
  [toolbar sizeToFit];
  
  UIBarButtonItem *prevButton = [[UIBarButtonItem alloc]
                                 initWithTitle: @"Previous"
                                 style: UIBarButtonItemStyleDone
                                 target: self
                                 action:@selector(previousClicked:)];
  prevButton.tag = prevTag;
  
  UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                 initWithTitle: @"Next"
                                 style: UIBarButtonItemStyleDone
                                 target: self
                                 action:@selector(nextClicked:)];
  nextButton.tag = nextTag;
  
  UIBarButtonItem *flexButton = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                 target: self
                                 action: nil];
  
  UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                target: self
                                action: @selector(doneClicked:)];
  doneButton.tag = tag;
  
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
