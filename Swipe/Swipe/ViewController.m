//
//  ViewController.m
//  Swipe
//
//  Created by Michael Shafae on 10/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize color;

-(void) updatedBackground{
    self.view.backgroundColor = [UIColor colorWithRed:self.color.red green:self.color.green blue:self.color.blue alpha:1.0];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.color = [[MutableColor alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBlueGesture:(UISwipeGestureRecognizer*)sender{
    if(self.color.blue <= 1.0){
        self.color.blue += 0.1;
    }else{
        self.color.blue = 1.0;
    }
    [self updatedBackground];
}

- (IBAction)subtractBlueGesture:(UISwipeGestureRecognizer*)sender{
    if(self.color.blue >= 0.0){
        self.color.blue -= 0.1;
    }else{
        self.color.blue = 0.0;
    }
    [self updatedBackground];
}

- (IBAction)addGreenGesture:(UISwipeGestureRecognizer*)sender{
    if(self.color.green <= 1.0){
        self.color.green += 0.1;
    }else{
        self.color.green = 1.0;
    }
    [self updatedBackground];
}

- (IBAction)subtractGreenGesture:(UISwipeGestureRecognizer*)sender{
    if(self.color.green >= 0.0){
        self.color.green -= 0.1;
    }else{
        self.color.green = 0.0;
    }
    [self updatedBackground];
}

- (IBAction)subtractRedGesture:(UILongPressGestureRecognizer *)sender {
    if(self.color.red >= 0.0){
        self.color.red -= 0.1;
    }else{
        self.color.red = 0.0;
    }
    [self updatedBackground];

}

- (IBAction)resetColorsGesture:(UIPinchGestureRecognizer *)sender {
    self.color.red = self.color.green = self.color.blue = 1.0;
    [self updatedBackground];
}

@end
