//
//  RedViewController.m
//  NavigationViewControllerDemo
//
//  Created by Shafae, Michael on 9/29/14.
//  Copyright (c) 2014 CSU Fullerton. All rights reserved.
//

#import "RedViewController.h"
#import "BlueViewController.h"

@interface RedViewController ()

@end

@implementation RedViewController

@synthesize aWord;

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
    self.addressLabel.text = [NSString stringWithFormat:@"%p", self];
    self.aWord = @"cat";
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    RedViewController* rvc;
    BlueViewController* bvc;
    rvc = segue.sourceViewController;
    bvc = segue.destinationViewController;
    bvc.secretWord = rvc.aWord;
    
}


@end
