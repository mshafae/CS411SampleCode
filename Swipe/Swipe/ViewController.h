//
//  ViewController.h
//  Swipe
//
//  Created by Michael Shafae on 10/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MutableColor.h"

@interface ViewController : UIViewController

@property (retain) MutableColor* color;

- (IBAction)addBlueGesture:(UISwipeGestureRecognizer*)sender;
- (IBAction)subtractBlueGesture:(UISwipeGestureRecognizer*)sender;
- (IBAction)addGreenGesture:(UISwipeGestureRecognizer*)sender;
- (IBAction)subtractGreenGesture:(UISwipeGestureRecognizer*)sender;
- (IBAction)subtractRedGesture:(UILongPressGestureRecognizer *)sender;
- (IBAction)resetColorsGesture:(UIPinchGestureRecognizer *)sender;

@end
