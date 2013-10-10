//
//  MutableColor.h
//  Swipe
//
//  Created by Michael Shafae on 10/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface MutableColor : NSObject

-(id) init;
@property (assign) CGFloat red;
@property (assign) CGFloat green;
@property (assign) CGFloat blue;

@end
