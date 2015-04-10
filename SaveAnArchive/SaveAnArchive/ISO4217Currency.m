//
//  ISO4217Currency.m
//  SaveAnArchive
//
//  Created by Michael Shafae on 4/10/15.
//  Copyright (c) 2015 Michael Shafae. All rights reserved.
//

#import "ISO4217Currency.h"

@implementation ISO4217Currency

@synthesize country;
@synthesize currency;
@synthesize alphaCode;

+(BOOL) supportsSecureCoding
{
  return YES;
}

-(ISO4217Currency*) initWithCountry: (NSString*) aCountry Currency: (NSString*) aCurrency AlphaCode:(NSString*) anAlphaCode
{
  self = [super init];
  if (self) {
    country = aCountry;
    currency = aCurrency;
    alphaCode = anAlphaCode;
  }
  return self;
}

-(ISO4217Currency*) initWithCoder: (NSCoder*) aDecoder
{
  self = [super init];
  if(self){
    self.country = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"country"];
    self.currency = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"currency"];
    self.alphaCode = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"alphaCode"];
  }
  return self;
}

-(void) encodeWithCoder: (NSCoder*) anEncoder
{
  [anEncoder encodeObject: self.country forKey: @"country"];
  [anEncoder encodeObject: self.currency forKey: @"currency"];
  [anEncoder encodeObject: self.alphaCode forKey: @"alphaCode"];
}

-(NSString*) description
{
  return [NSString stringWithFormat: @"%@ %@ %@", self.country, self.currency, self.alphaCode];
}

@end
