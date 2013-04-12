//
//  MSViewController.h
//  BSDFortune
//
//  Created by Michael Shafae on 4/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController <UIWebViewDelegate>
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
