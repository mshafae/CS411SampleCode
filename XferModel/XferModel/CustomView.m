//
//  CustomView.m
//  XferModel
//
//  Created by Michael Shafae on 10/10/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

@synthesize m;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGFloat x = 30.0 + self.m.x % 100;
    CGFloat y = 30.0 + self.m.y % 100;
    NSLog(@"x: %g, y: %g", x, y);
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddRect(context, CGRectMake(x, y, 60.0, 60.0));
    CGContextStrokePath(context);
}


@end
