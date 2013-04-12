//
//  MSAphorism.m
//  BSDFortune
//
//  Created by Michael Shafae on 4/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "MSAphorism.h"

@implementation MSAphorism

@synthesize text;
@synthesize ident;

-(MSAphorism*) initWithID: (unsigned int) anIdent AndText: (NSString*) anAphorism
{
  self = [super init];
  if( self ){
    text = anAphorism;
    ident = anIdent;
  }
  return self;
}

-(NSString*) HTMLtext
{
  return [NSString stringWithFormat: @"<html><p>%@</p></html>", self.text];
}
@end
