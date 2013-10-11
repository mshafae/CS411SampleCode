//
//  ViewController.m
//  XferModel
//
//  Created by Michael Shafae on 10/10/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import <stdlib.h>
#import <time.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

@synthesize m;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    FirstViewController* me = (FirstViewController*)(segue.sourceViewController);
    SecondViewController* you = (SecondViewController*)(segue.destinationViewController);
    you.other_m = me.m;
}

- (IBAction)recognizeSwipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"In first view controller, I recognized a swipe.");
    if( self.m == nil){
        self.m = [[Model alloc] init];
        srand(time(0));
    }
    self.m.x = rand( );
    self.m.y = rand( );
    [self performSegueWithIdentifier:@"fromFirstToSecond" sender:self];
}
@end
