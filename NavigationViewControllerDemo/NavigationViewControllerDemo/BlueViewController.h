//
//  BlueViewController.h
//  NavigationViewControllerDemo
//
//  Created by Shafae, Michael on 9/29/14.
//  Copyright (c) 2014 CSU Fullerton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *secretLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) NSString* secretWord;

@end
