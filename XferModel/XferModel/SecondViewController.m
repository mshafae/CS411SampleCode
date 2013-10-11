//
//  SecondViewController.m
//  XferModel
//
//  Created by Michael Shafae on 10/10/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize other_m;

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
    CustomView *cv = (CustomView*)(self.view);
    cv.m = self.other_m;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recognizeSwipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"In second view controller, I recognized a swipe.");
    [self performSegueWithIdentifier:@"fromSecondToFirst" sender:self];

}
@end
