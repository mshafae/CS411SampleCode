//
//  ViewController.m
//  FractionalViewDemo
//
//  Created by Michael Shafae on 11/10/15.
//  Copyright © 2015 Michael Shafae. All rights reserved.
//

#import "ViewController.h"
#import "FractionalNumber.h"
#import "FractionalNumberView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  FractionalNumber* num = [[FractionalNumber alloc] initWithNumerator: 2 denominator: 3];
  ((FractionalNumberView*)self.view).fraction = num;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
