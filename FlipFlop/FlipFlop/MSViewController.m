//
//  MSViewController.m
//  FlipFlop
//
//  Created by Shafae, Michael on 2/20/14.
//  Copyright (c) 2014 BigCorp. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"This is MSViewController! %p", (__bridge void*)self);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
