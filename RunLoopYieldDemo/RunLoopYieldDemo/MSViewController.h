//
//  MSViewController.h
//  RunLoopYieldDemo
//
//  Created by Michael Shafae on 3/14/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)goPressed:(UIButton *)sender;
- (IBAction)resetPressed:(UIButton *)sender;

@end
