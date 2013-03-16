//
//  OtherViewController.m
//  SeguewayDemo
//
//  Created by Michael Shafae on 2/26/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "OtherViewController.h"
#import "ViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

@synthesize visitingModel;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  NSLog(@"OVC: view did load");
  self.label.text = self.visitingModel.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSLog(@"prepareForSegue: %@", segue.identifier);
  ((ViewController*)(segue.destinationViewController)).model = self.visitingModel;
}

@end
