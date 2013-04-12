//
//  USLocationsDatabase.m
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import "FortuneDatabase.h"
#import <stdlib.h>
#import <assert.h>

#define SWAP(a, b) (((a) == (b)) || (((a) ^= (b)), ((b) ^= (a)), ((a) ^= (b))))

@implementation FortuneDatabase

static FortuneDatabase* _fortunedatabaseObj;

+ (FortuneDatabase*) database
{
  if (_fortunedatabaseObj == nil) {
    _fortunedatabaseObj = [[FortuneDatabase alloc] init];
  }
  return _fortunedatabaseObj;
}

- (id) init{
  self = [super init];
  if (self) {
    NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"freebsd_fortunes_clean" ofType:@"sl3"];
    if (sqlite3_open([dbpath UTF8String], &_databaseConnection) != SQLITE_OK) {
      NSLog(@"Failed to open database.");
    }
    NSString* query = @"SELECT COUNT(id) from fortunes;";
    sqlite3_stmt *stmt;
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
      while( sqlite3_step(stmt) == SQLITE_ROW){
        _count = sqlite3_column_int(stmt, 0);
        NSLog(@"There are %d rows", _count);
      }
    }else{
      NSLog(@"Can't get a count!");
    }
    sqlite3_finalize(stmt);
    srand(time(NULL));
    _shuffle = (unsigned int*)calloc(_count, sizeof(unsigned int));
    for (int i = 0; i < _count; i++) {
      _shuffle[i] = i + 1;
    }
    for (int i = 0; i < _count; i++) {
      unsigned int j = rand( ) % _count;
      SWAP(_shuffle[i], _shuffle[j]);
    }
  }
  return self;
}

- (void) dealloc
{
  sqlite3_close(_databaseConnection);
}

- (MSAphorism*) next
{
  int nextIndex = _shuffle[_counter];
  if( _counter < _count ){
    _counter++;
  }else{
    _counter = 0;
  }
  const char* query = "SELECT aphorism FROM fortunes where id=%d;";
  char buffer[48];
  sprintf(buffer, query, nextIndex);
  //NSLog(@"%s", buffer);
  sqlite3_stmt *stmt;
  NSString* aphorismText;
  const unsigned char* text = NULL;
  if( sqlite3_prepare_v2(_databaseConnection, buffer, strlen(buffer), &stmt, nil) == SQLITE_OK){
    while( sqlite3_step(stmt) == SQLITE_ROW){
      // Should only have one row returned, but we'll take the last one out of the loop
      text = sqlite3_column_text(stmt, 0);
      aphorismText = [NSString stringWithCString: (const char*)text encoding: NSASCIIStringEncoding];
      //NSLog(@"in the loop:\n%s\n%@", text, aphorismText);
    }
  }else{
    NSLog(@"Failed query!");
  }
  sqlite3_finalize(stmt);
  MSAphorism* aphorism = [[MSAphorism alloc] initWithID: nextIndex AndText: aphorismText];

  return aphorism;
}

@end
