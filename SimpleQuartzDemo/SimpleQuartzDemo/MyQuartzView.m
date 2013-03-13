//
//  MyQuartzView.m
//  SimpleQuartzDemo
//
//  Created by Michael Shafae on 3/7/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

// Drawing code taken from the Apple QuartzDemo
// <http://developer.apple.com/library/ios/#samplecode/QuartzDemo/Introduction/Intro.html>

#import "MyQuartzView.h"

@implementation MyQuartzView

@synthesize demo;

- (id)initWithFrame:(CGRect)frame
{
  NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
  NSLog(@"initWithCoder");
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Initialization code
    self.demo = 0;
    self.backgroundColor = [UIColor blackColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = YES;
  }
  return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  CGContextRef context = UIGraphicsGetCurrentContext();
  switch (self.demo) {
    case 0:
      // Drawing with a white stroke color
      CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
      // And drawing with a blue fill color
      CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
      // Draw them with a 2.0 stroke width so they are a bit more visible.
      CGContextSetLineWidth(context, 2.0);
      
      // Add Rect to the current path, then stroke it
      CGContextAddRect(context, CGRectMake(30.0, 30.0, 60.0, 60.0));
      CGContextStrokePath(context);
      
      // Stroke Rect convenience that is equivalent to above
      CGContextStrokeRect(context, CGRectMake(30.0, 120.0, 60.0, 60.0));
      
      // Stroke rect convenience equivalent to the above, plus a call to CGContextSetLineWidth().
      CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 10.0);
      // Demonstate the stroke is on both sides of the path.
      CGContextSaveGState(context);
      CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
      CGContextStrokeRectWithWidth(context, CGRectMake(30.0, 210.0, 60.0, 60.0), 2.0);
      CGContextRestoreGState(context);
      
      CGRect rects[] =
      {
        CGRectMake(120.0, 30.0, 60.0, 60.0),
        CGRectMake(120.0, 120.0, 60.0, 60.0),
        CGRectMake(120.0, 210.0, 60.0, 60.0),
      };
      // Bulk call to add rects to the current path.
      CGContextAddRects(context, rects, sizeof(rects)/sizeof(rects[0]));
      CGContextStrokePath(context);
      
      // Create filled rectangles via two different paths.
      // Add/Fill path
      CGContextAddRect(context, CGRectMake(210.0, 30.0, 60.0, 60.0));
      CGContextFillPath(context);
      // Fill convienience.
      CGContextFillRect(context, CGRectMake(210.0, 120.0, 60.0, 60.0));
      break;
    case 1:
      // Drawing lines with a white stroke color
      CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
      // Draw them with a 2.0 stroke width so they are a bit more visible.
      CGContextSetLineWidth(context, 2.0);
      
      // Draw a single line from left to right
      CGContextMoveToPoint(context, 10.0, 30.0);
      CGContextAddLineToPoint(context, 310.0, 30.0);
      CGContextStrokePath(context);
      
      // Draw a connected sequence of line segments
      CGPoint addLines[] =
    {
      CGPointMake(10.0, 90.0),
      CGPointMake(70.0, 60.0),
      CGPointMake(130.0, 90.0),
      CGPointMake(190.0, 60.0),
      CGPointMake(250.0, 90.0),
      CGPointMake(310.0, 60.0),
    };
      // Bulk call to add lines to the current path.
      // Equivalent to MoveToPoint(points[0]); for(i=1; i<count; ++i) AddLineToPoint(points[i]);
      CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
      CGContextStrokePath(context);
      
      // Draw a series of line segments. Each pair of points is a segment
      CGPoint strokeSegments[] =
    {
      CGPointMake(10.0, 150.0),
      CGPointMake(70.0, 120.0),
      CGPointMake(130.0, 150.0),
      CGPointMake(190.0, 120.0),
      CGPointMake(250.0, 150.0),
      CGPointMake(310.0, 120.0),
    };
      // Bulk call to stroke a sequence of line segments.
      // Equivalent to for(i=0; i<count; i+=2) { MoveToPoint(point[i]); AddLineToPoint(point[i+1]); StrokePath(); }
      CGContextStrokeLineSegments(context, strokeSegments, sizeof(strokeSegments)/sizeof(strokeSegments[0]));
      break;
    default:
      NSLog(@"You should not be seeing this.");
      break;
      
  }

}


@end
