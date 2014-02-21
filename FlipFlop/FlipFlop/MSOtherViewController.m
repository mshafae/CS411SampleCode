//
//  MSOtherViewController.m
//  FlipFlop
//
//  Created by Shafae, Michael on 2/20/14.
//  Copyright (c) 2014 BigCorp. All rights reserved.
//

#import "MSOtherViewController.h"

@interface MSOtherViewController ()

@end

@implementation MSOtherViewController

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
    NSLog(@"This is MSOtherViewController! %p", (__bridge void*)self);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
