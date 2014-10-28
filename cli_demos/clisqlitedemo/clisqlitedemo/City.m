//
//  City.m
//  clisqlitedemo
//
//  Created by Michael Shafae on 3/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "City.h"

@implementation City

@synthesize country;
@synthesize city;
@synthesize accentCity;
@synthesize region;
@synthesize population;
@synthesize coord;

- (id) initWithCountry: (NSString*) aCountry andCity: (NSString*) aCity andAccentCity: (NSString*) anAccentCity andRegion: (NSString*) aRegion andPopulation: (NSNumber*) thePopulation andLatitude: (double)theLatitude andLongitude: (double) theLongitude
{
  self = [super init];
  if(self){
    country = aCountry;
    city = aCity;
    accentCity = anAccentCity;
    region = aRegion;
    population = thePopulation;
    coord = CLLocationCoordinate2DMake(theLatitude, theLongitude);
  }
  return self;
}

- (NSString*) description
{
  [NSNumberFormatter localizedStringFromNumber:self.population numberStyle: NSNumberFormatterDecimalStyle];
  return [NSString stringWithFormat:@"%@, %@, %@ (%@, %@) has a population of %@",
          [self.city capitalizedString], [self.region uppercaseString], [self.country uppercaseString],
          [NSNumberFormatter localizedStringFromNumber: [NSNumber numberWithDouble: self.coord.latitude] numberStyle: NSNumberFormatterDecimalStyle],
          [NSNumberFormatter localizedStringFromNumber: [NSNumber numberWithDouble: self.coord.longitude] numberStyle: NSNumberFormatterDecimalStyle],
          [NSNumberFormatter localizedStringFromNumber:self.population numberStyle: NSNumberFormatterDecimalStyle]];
}

@end
