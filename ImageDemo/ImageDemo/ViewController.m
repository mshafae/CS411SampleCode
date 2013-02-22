//
//  ViewController.m
//  ImageDemo
//
//  Created by Michael Shafae on 2/21/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
  BOOL _toggle;
}
@property (assign) BOOL toggle;
@end

@implementation ViewController

@synthesize myImageView = _myImageView;
@synthesize toggle = _toggle;

-(IBAction) changeButtonPressed: (UIButton*) sender
{
  NSBundle* myMainBundle = [NSBundle mainBundle];
  NSString* otherImagePath;
  UIImage* myOtherImage;
  if (self.toggle) {
    otherImagePath = [myMainBundle pathForResource: @"_DSC0426" ofType: @"jpg"];
    myOtherImage = [UIImage imageWithContentsOfFile:otherImagePath];
  }else{
    otherImagePath = [myMainBundle pathForResource: @"cropped-roll-93_0015732-R02-020" ofType: @"jpg"];
    myOtherImage = [UIImage imageWithContentsOfFile:otherImagePath];
  }
  self.toggle = !self.toggle;
  self.myImageView.image = myOtherImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.toggle = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
