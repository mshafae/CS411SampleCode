//
//  BlueViewController.m
//  NavigationViewControllerDemo
//
//  Created by Shafae, Michael on 9/29/14.
//  Copyright (c) 2014 CSU Fullerton. All rights reserved.
//

#import "BlueViewController.h"

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
    self.addressLabel.text = [NSString stringWithFormat:@"%p", self];
    self.secretLabel.text = self.secretWord;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
