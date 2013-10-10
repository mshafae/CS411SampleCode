//
//  MutableColor.m
//  Swipe
//
//  Created by Michael Shafae on 10/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "MutableColor.h"

@implementation MutableColor

@synthesize red;
@synthesize green;
@synthesize blue;

-(id) init{
    self = [super init];
    if(self){
        self.red = 1.0;
        self.green = 1.0;
        self.blue = 1.0;
    }
    return self;
}
@end
