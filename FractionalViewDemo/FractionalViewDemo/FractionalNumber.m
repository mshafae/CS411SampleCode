//
//  FractionalNumber.m
//  FractionalNumber
//
//  Created by Michael Shafae on 10/1/14.
//  Copyright (c) 2014 Michael Shafae. All rights reserved.
//

#import "FractionalNumber.h"
#import <assert.h>
#import <stdint.h>

@implementation FractionalNumber

@synthesize numerator;
@synthesize denominator;

-(FractionalNumber*) initWithNumerator: (int) aNumerator denominator: (int) aDenominator
{
  assert(aDenominator > 0);
  self = [super init];
  if( self ){
    numerator = aNumerator;
    denominator = aDenominator;
  }
  return self;
}

-(NSString*) stringValue
{
  NSString *rv;
  if( self.numerator > self.denominator ){
    int q = self.numerator / self.denominator;
    int r = self.numerator % self.denominator;
    if( r == 0 ){
      rv = [NSString stringWithFormat: @"%d", q];
    }else{
      rv = [NSString stringWithFormat: @"%d %d/%d", q, r, self.denominator];
    }
  }else{
    rv = [NSString stringWithFormat: @"%d/%d", self.numerator, self.denominator];
  }
  return rv;
}

-(NSString*) description
{
  return [self stringValue];
}


@end
