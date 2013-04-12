//
//  USLocationsDatabase.m
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import "CitiesDatabase.h"

@implementation CitiesDatabase

static CitiesDatabase* _databaseObj;

+ (CitiesDatabase*) database
{
  if (_databaseObj == nil) {
    _databaseObj = [[CitiesDatabase alloc] init];
  }
  return _databaseObj;
}

- (id) init{
  self = [super init];
  if (self) {
    NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"sq3"];
    if (sqlite3_open([dbpath UTF8String], &_databaseConnection) != SQLITE_OK) {
      NSLog(@"Failed to open database.");
    }
  }
  return self;
}

- (void) dealloc
{
  sqlite3_close(_databaseConnection);
}

- (NSArray*) californiaLocations
{
  NSMutableArray* rv = [[NSMutableArray alloc] init];
  NSString* query = @"SELECT * FROM cities where region='CA';";
  sqlite3_stmt *stmt;
  const unsigned char* text;
  NSString *country, *city, *accentcity, *region;
  double longitude, latitude;
  int population;
  if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
    while( sqlite3_step(stmt) == SQLITE_ROW){
      text = sqlite3_column_text(stmt, 0);
      if( text )
        country = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        country = nil;
      text = sqlite3_column_text(stmt, 1);
      if(text)
        city = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        city = nil;
      text = sqlite3_column_text(stmt, 2);
      if(text)
        accentcity = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        accentcity = nil;
      text = sqlite3_column_text(stmt, 3);
      if(text)
        region = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        region = nil;
      population = sqlite3_column_double(stmt, 4);
      longitude = sqlite3_column_double(stmt, 5);
      latitude = sqlite3_column_double(stmt, 6);
      CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(longitude, latitude);
      Location *thisLocation = [[Location alloc] initWithCounty:country andCity: city andAccentCity: accentcity andRegion: region andPopulation: population andCoordinate: coord];
      [rv addObject: thisLocation];
    }
    sqlite3_finalize(stmt);
  }
  return rv;
}

- (NSArray*) allLocations
{
  NSMutableArray* rv = [[NSMutableArray alloc] init];
  NSString* query = @"SELECT * FROM cities;";
  sqlite3_stmt *stmt;
  const unsigned char* text;
  NSString *country, *city, *accentcity, *region;
  double longitude, latitude;
  int population;
  if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
    while( sqlite3_step(stmt) == SQLITE_ROW){
      text = sqlite3_column_text(stmt, 0);
      if( text )
        country = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        country = nil;
      text = sqlite3_column_text(stmt, 1);
      if(text)
        city = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        city = nil;
      text = sqlite3_column_text(stmt, 2);
      if(text)
        accentcity = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        accentcity = nil;
      text = sqlite3_column_text(stmt, 3);
      if(text)
        region = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
      else
        region = nil;
      population = sqlite3_column_double(stmt, 4);
      longitude = sqlite3_column_double(stmt, 5);
      latitude = sqlite3_column_double(stmt, 6);
      CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(longitude, latitude);
      Location *thisLocation = [[Location alloc] initWithCounty:country andCity: city andAccentCity: accentcity andRegion: region andPopulation: population andCoordinate: coord];
      [rv addObject: thisLocation];
    }
    sqlite3_finalize(stmt);
  }
  return rv;
}

@end
