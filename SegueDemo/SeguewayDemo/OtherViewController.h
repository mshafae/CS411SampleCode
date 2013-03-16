//
//  OtherViewController.h
//  SeguewayDemo
//
//  Created by Michael Shafae on 2/26/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface OtherViewController : UIViewController

@property (retain, nonatomic) MyModel* visitingModel;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
