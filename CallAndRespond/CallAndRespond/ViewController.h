//
//  ViewController.h
//  CallAndRespond
//
//  Created by Michael Shafae on 2/19/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
  IBOutlet UILabel* _myLabel;
  //  UIButton* _myButton;
  IBOutlet UITextField* _myTextField;
}

@property IBOutlet UILabel* myLabel;
@property IBOutlet UITextField* myTextField;

-(IBAction)buttonPressed:(UIButton*)sender;

@end
