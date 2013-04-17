//
//  Location.h
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location : NSObject

@property (nonatomic, retain) NSString* country;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* accentCity;
@property (nonatomic, retain) NSString* region;
@property (nonatomic, retain) NSNumber* population;
@property (readonly) CLLocationCoordinate2D coord;
@property (readonly) NSString* longitudeString;
@property (readonly) NSString* latitudeString;

- (id) initWithCounty: (NSString*) theCountry andCity: (NSString*) theCity andAccentCity: (NSString*) theAccentCity andRegion: (NSString*) theRegion andPopulation: (int) thePopulation andCoordinate: (CLLocationCoordinate2D) theCoordinate;

- (NSString*) description;

- (NSString*) longitudeString;

- (NSString*) latitudeString;

@end
