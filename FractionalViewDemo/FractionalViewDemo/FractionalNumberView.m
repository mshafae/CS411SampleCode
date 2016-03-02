//
//  FractionalNumberView.m
//  FractionalViewDemo
//
//  Created by Michael Shafae on 11/10/15.
//  Copyright © 2015 Michael Shafae. All rights reserved.
//

#import "FractionalNumberView.h"
#import "assert.h"

float lineWidthFromCGSize(CGSize size){
  float width = size.height / 30.0;
  if( width < 2 ){
    width = 2.0;
  }
  return width;
}

NSString* CGRectDescription(NSString* rectName, CGRect* rect){
  if( rectName == nil ){
    rectName = @"Rect";
  }
  return [NSString stringWithFormat:
   @"%@ origin: x: %g, y: %g  size: w: %g, h: %g",
   rectName, rect->origin.x, rect->origin.y,
   rect->size.width, rect->size.height];
}

@implementation UIColor (InverseColorExtension)
-(UIColor*) inverse
{
  CGFloat red, green, blue, alpha;
  [self getRed: &red green: &green blue: &blue alpha: &alpha];
  return [UIColor colorWithRed: (1.0f - red)
                         green: (1.0f - green)
                          blue: (1.0f - blue)
                         alpha: alpha];
}

@end

@implementation FractionalNumberView
@synthesize fraction;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // width / 16
  float margin = rect.size.width * .0625;
  
  // width / 2
  //float halfWidth = rect.size.width * 0.5;
  // height / 2
  float halfHeight = rect.size.height * 0.5;
  
  CGRect upperRect;
  CGRect lowerRect;
  // 1. Divide larger rect into two equal sized
  //    component rectangles; upper and lower
  // 2. Inset a smaller rectangle (by 16%)
  CGRectDivide(rect, &lowerRect, &upperRect, halfHeight, CGRectMaxYEdge);
  upperRect = CGRectInset(upperRect, margin, margin);
  lowerRect = CGRectInset(lowerRect, margin, margin);
  
  NSString* numeratorString = [@(self.fraction.numerator) stringValue];
  NSString* denominatorString = [@(self.fraction.denominator) stringValue];
  
  // Drawing code
  CGContextRef context = UIGraphicsGetCurrentContext( );

  CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
  CGContextSetLineWidth(context, lineWidthFromCGSize(rect.size));
  // Draw a single line from left to right
  CGContextMoveToPoint(context, margin, halfHeight);
  CGContextAddLineToPoint(context, rect.size.width - margin, halfHeight);
  CGContextStrokePath(context);

  // Prepare to draw the numerator and denominator by setting up a font
  // and the text's color.
  UIFont* font = [UIFont systemFontOfSize: upperRect.size.height];
  UIColor* textColor = [self.backgroundColor inverse];
  NSDictionary* stringAttributes = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
  NSAttributedString* numeratorAttributedString = [[NSAttributedString alloc] initWithString: numeratorString attributes: stringAttributes];
  NSAttributedString* denominatorAttributedString = [[NSAttributedString alloc] initWithString: denominatorString attributes: stringAttributes];
  // Draw the text
  [numeratorAttributedString drawAtPoint: upperRect.origin];
  [denominatorAttributedString drawAtPoint: lowerRect.origin];
}

@end
