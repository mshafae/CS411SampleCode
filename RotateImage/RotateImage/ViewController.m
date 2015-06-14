//
//  ViewController.m
//  RotateImage
//
//  Created by Michael Shafae on 6/13/15.
//  Copyright (c) 2015 Michael Shafae. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  // Get a pointer to the image from the image view.
  UIImage* image = self.imageView.image;
  
  // Derive the new frame size by rotating the current image's frame size.
  CGRect originalImageFrame = CGRectMake(0, 0, image.size.width, image.size.height);
  CGAffineTransform rotateByNinetyDegrees = CGAffineTransformMakeRotation(M_PI/2.0);
  CGRect rotatedImageFrame = CGRectApplyAffineTransform(originalImageFrame, rotateByNinetyDegrees);
  CGSize rotatedImageFrameSize = rotatedImageFrame.size;
  
  // Get a graphics context
  UIGraphicsBeginImageContext(rotatedImageFrameSize);
  CGContextRef imageGraphicsContext = UIGraphicsGetCurrentContext( );
  
  // Move the coordinate system's origin to the center of the image
  // in preparation for the rotation.
  CGContextTranslateCTM(imageGraphicsContext, rotatedImageFrameSize.width / 2, rotatedImageFrameSize.height / 2);
  
  CGContextRotateCTM(imageGraphicsContext, M_PI/2.0);
  
  // Flip the image, the image's coordinate system and iOS's are different.
  CGContextScaleCTM(imageGraphicsContext, 1.0, -1.0);
  
  // Draw the image
  CGContextDrawImage(imageGraphicsContext, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
  UIImage *newRotatedImage = UIGraphicsGetImageFromCurrentImageContext( );
  UIGraphicsEndImageContext( );

  // Set the rotated image to the image view's image pointer
  self.imageView.image = newRotatedImage;
  
}
@end
