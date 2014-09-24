//
//  BlueViewController.m
//  swipedemo
//
//  Created by Shafae, Michael on 9/24/14.
//  Copyright (c) 2014 CSU Fullerton. All rights reserved.
//

#import "BlueViewController.h"
#import "RedViewController.h"

@interface BlueViewController ()

@end

@implementation BlueViewController

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
    NSLog(@"I'm in the blue view controller (%p)!", self);
    self.pointerLabel.text = [NSString stringWithFormat:@"%p", self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier compare: @"buttonSegue"] == NSOrderedSame){
        NSLog(@"We're using the Button!");
    }else{
        NSLog(@"No button pressed...");
    }
    RedViewController *rvc = (RedViewController*)segue.destinationViewController;
    rvc.model = @"We did it";
    NSLog(@"We're preparing for a segue");
    NSLog(@"self: %p sender: %p", self, sender);
    NSLog(@"src: %p dst: %p", segue.sourceViewController, segue.destinationViewController);
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
