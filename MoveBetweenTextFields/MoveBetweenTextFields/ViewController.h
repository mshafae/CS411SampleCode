//
//  ViewController.h
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 2/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfA;
@property (weak, nonatomic) IBOutlet UITextField *tfB;

@end
