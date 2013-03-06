//
//  ViewController.h
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 2/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfA;
@property (weak, nonatomic) IBOutlet UITextField *tfB;
@property (weak, nonatomic) UITextField *activeTF;

@end
