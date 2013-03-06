//
//  UITextField+NextTextFieldProperty.m
//  MoveBetweenTextFields
//
//  Created by Michael Shafae on 3/5/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "UITextField+NextTextFieldProperty.h"
#import <objc/runtime.h>

static Byte defaultHashKey;

@implementation UITextField (NextTextFieldProperty)

-(UITextField*) nextTextField
{
  return objc_getAssociatedObject( self, &defaultHashKey );
}

-(void) setNextTextField: (UITextField *)nextTextField
{
  objc_setAssociatedObject( self, &defaultHashKey, nextTextField,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

@end
