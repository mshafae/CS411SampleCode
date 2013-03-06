//
//  ReversePushStoryboardSegue.m
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 3/5/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "ReversePushStoryboardSegue.h"


@implementation ReversePushStoryboardSegue

-(void) perform
{
  UIViewController *source = (UIViewController *)self.sourceViewController;
  UIViewController *destination = (UIViewController *)self.destinationViewController;
  
  [UIView transitionWithView: source.navigationController.view
          duration:0.5
          options: UIViewAnimationOptionTransitionFlipFromLeft
          animations:^{
            [source.navigationController
             pushViewController: destination animated: NO];
          }
          completion: NULL];
}

@end
