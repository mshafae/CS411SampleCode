//
//  ViewController.h
//  SeguewayDemo
//
//  Created by Michael Shafae on 2/26/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) MyModel* model;
@end
