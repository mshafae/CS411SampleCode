//
//  RedViewController.h
//  swipedemo
//
//  Created by Shafae, Michael on 9/24/14.
//  Copyright (c) 2014 CSU Fullerton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *secretMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointerLabel;
@property (retain, nonatomic) NSString* model;

@end
