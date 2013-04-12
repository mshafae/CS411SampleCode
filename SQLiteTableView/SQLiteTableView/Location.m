//
//  Location.m
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize country;
@synthesize city;
@synthesize accentCity;
@synthesize region;
@synthesize population;
@synthesize coord;

- (id) initWithCounty: (NSString*) theCountry andCity: (NSString*) theCity andAccentCity: (NSString*) theAccentCity andRegion: (NSString*) theRegion andPopulation: (int) thePopulation andCoordinate: (CLLocationCoordinate2D) theCoordinate;
{
  self = [super init];
  if( self ){
    country = theCountry;
    city = theCity;
    accentCity = theAccentCity;
    region = theRegion;
    population = [NSNumber numberWithInt:thePopulation];
    coord = CLLocationCoordinate2DMake(theCoordinate.longitude, theCoordinate.latitude);
  }
  return self;
}

- (NSString*) description
{
  return [NSString stringWithFormat:@"%@ %@ %@ %d %g %g", city, region, country, [population integerValue], coord.latitude, coord.longitude];
}

/*- (CLLocationCoordinate2D*) coord
{
  return &coord;
}*/

@end
