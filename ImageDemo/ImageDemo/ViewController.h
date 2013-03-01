//
//  ViewController.h
//  ImageDemo
//
//  Created by Michael Shafae on 2/21/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
  UIImageView* _myImageView;
}

@property IBOutlet UIImageView* myImageView;

-(IBAction) changeButtonPressed: (UIButton*) sender;

@end
