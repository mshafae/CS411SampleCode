//
//  City.h
//  clisqlitedemo
//
//  Created by Michael Shafae on 3/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface City : NSObject
@property (retain, readonly, nonatomic) NSString* country;
@property (retain, readonly, nonatomic) NSString* city;
@property (retain, readonly, nonatomic) NSString* accentCity;
@property (retain, readonly, nonatomic) NSString* region;
@property (retain, readonly, nonatomic) NSNumber* population;
@property (readonly) CLLocationCoordinate2D coord;

- (id) initWithCountry: (NSString*) aCountry andCity: (NSString*) aCity andAccentCity: (NSString*) anAccentCity andRegion: (NSString*) aRegion andPopulation: (NSNumber*) thePopulation andLatitude: (double)theLatitude andLongitude: (double) theLongitude;

- (NSString*) description;

@end
