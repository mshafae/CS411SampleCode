//
//  SecondViewController.h
//  XferModel
//
//  Created by Michael Shafae on 10/10/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "CustomView.h"

@interface SecondViewController : UIViewController

@property (retain) Model* other_m;

- (IBAction)recognizeSwipe:(UISwipeGestureRecognizer *)sender;

@end
