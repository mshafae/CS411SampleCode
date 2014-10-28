//
//  main.m
//  clisqlitedemo
//
//  Created by Michael Shafae on 3/28/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <stdio.h>
#import <stdlib.h>
#import "City.h"

static int callback(void *NotUsed, int argc, char **argv, char **azColName){
  int i;
  for(i=0; i<argc; i++){
    printf("%s = %s; ", azColName[i], argv[i] ? argv[i] : "NULL");
  }
  printf("\n");
  return 0;
}

void poor(sqlite3 *db){
  char *zErrMsg = 0;
  int rc;
  char city_str[50];
  int population;
  char query[128];
  
  // Interact with the user...
  printf("Please enter the U.S. state that you are interested in: ");
  scanf("%s", city_str);
  printf("Please enter the minimum population: ");
  scanf("%d", &population);
  
  sprintf(query, "SELECT city, population FROM cities WHERE REGION='%s' and POPULATION>%d;", city_str, population);
  
  rc = sqlite3_exec(db, query, callback, 0, &zErrMsg);
  
  if( rc!=SQLITE_OK ){
    fprintf(stderr, "SQL error: %s\n", zErrMsg);
    sqlite3_free(zErrMsg);
  }
}

void better(sqlite3 *db){
  int rv;
  const char* query_str_format = "SELECT * FROM cities WHERE REGION='%s' AND population>%d";
  char query[128];
  sqlite3_stmt* stmt;
  const char* tail;
  char city_str[50];
  int population;
  
  // Interact with the user...
  printf("Please enter the U.S. state that you are interested in: ");
  scanf("%s", city_str);
  printf("Please enter the minimum population: ");
  scanf("%d", &population);

  sprintf(query, query_str_format, city_str, population);
  
  rv = sqlite3_prepare_v2(db, query, (int)strlen(query), &stmt, &tail);
  if( rv != SQLITE_OK){
    NSLog(@"Can't prepare the statement %s", sqlite3_errmsg(db));
    NSLog(@"Tail: %s", tail);
    sqlite3_close(db);
    exit(1);
  }
  
  while(1){
    rv = sqlite3_step(stmt);
    if( rv == SQLITE_ROW){
      int bytes;
      const unsigned char* text;
      const char* colName;
      int i;
      double val;
      for(i = 0; i < 4; i++){
        text = sqlite3_column_text(stmt, i);
        bytes = sqlite3_column_bytes(stmt, i);
        colName = sqlite3_column_name(stmt, i);
        printf("%s = '%s' (%u)\n", colName, text, bytes);
      }
      // Demonstrate retrieval of different types
      text = sqlite3_column_text(stmt, i);
      bytes = sqlite3_column_bytes(stmt, i);
      colName = sqlite3_column_name(stmt, i);
      printf("%s = '%s' (%u)\n", colName, text, bytes);

      for(i = 5; i < 7; i++){
        val = sqlite3_column_double(stmt, i);
        bytes = sqlite3_column_bytes(stmt, i);
        text = sqlite3_column_text(stmt, i);
        colName = sqlite3_column_name(stmt, i);
        printf("%s = %g '%s' (%u)\n", colName, val, text, bytes);
      }
    }else if( rv == SQLITE_DONE){
      break;
    }else{
      NSLog(@"something is fishy.");
      sqlite3_finalize(stmt);
      sqlite3_close(db);
      exit(1);
    }
  }
  
  rv = sqlite3_finalize(stmt);
}

NSArray* evenBetter(sqlite3 *db){
  int rv;
  const char* query_str_format = "SELECT * FROM cities WHERE REGION='%s' AND population>%d";
  char query[128];
  sqlite3_stmt* stmt;
  const char* tail;
  char city_str[50];
  int population;
  NSMutableArray* cities = [[NSMutableArray alloc] initWithCapacity:5];
  // Interact with the user...
  printf("Please enter the U.S. state that you are interested in: ");
  scanf("%s", city_str);
  printf("Please enter the minimum population: ");
  scanf("%d", &population);
  
  sprintf(query, query_str_format, city_str, population);
  
  rv = sqlite3_prepare_v2(db, query, (int)strlen(query), &stmt, &tail);
  if( rv != SQLITE_OK){
    NSLog(@"Can't prepare the statement %s", sqlite3_errmsg(db));
    NSLog(@"Tail: %s", tail);
    sqlite3_close(db);
    exit(1);
  }
  // We're allocating a lot of objects potentially, wrap in an autorelease pool...
  @autoreleasepool {
    while(1){
      rv = sqlite3_step(stmt);
      if( rv == SQLITE_ROW){
        NSString *country = [NSString stringWithCString: (const char*)sqlite3_column_text(stmt, 0) encoding: NSASCIIStringEncoding];
        NSString *city = [NSString stringWithCString: (const char*)sqlite3_column_text(stmt, 1) encoding: NSASCIIStringEncoding];
        NSString *accentcity = [NSString stringWithCString: (const char*)sqlite3_column_text(stmt, 2) encoding: NSASCIIStringEncoding];
        NSString *region = [NSString stringWithCString: (const char*)sqlite3_column_text(stmt, 3) encoding: NSASCIIStringEncoding];
        NSNumber* population = [NSNumber numberWithInt:sqlite3_column_int(stmt, 4)];
        double latitude = sqlite3_column_double(stmt, 5);
        double longitude = sqlite3_column_double(stmt, 6);
        City* cityObj = [[City alloc] initWithCountry:country andCity:city andAccentCity:accentcity andRegion:region andPopulation:population andLatitude:latitude andLongitude:longitude];
        [cities addObject: cityObj];
      }else if( rv == SQLITE_DONE){
        break;
      }else{
        NSLog(@"something is fishy.");
        sqlite3_finalize(stmt);
        sqlite3_close(db);
        exit(1);
      }
    }
  }
  
  rv = sqlite3_finalize(stmt);
  return (NSArray*)cities;
}

int main(int argc, const char * argv[]){

  @autoreleasepool {
    sqlite3 *db;
    int rc;
    rc = sqlite3_open("cities.sq3", &db);
    if( rc ){
      fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
      sqlite3_close(db);
      exit(1);
    }
    //poor(db);
    printf("Attempt #2\n");
    //better(db);
    printf("Attempt #3\n");
    NSArray *cities = evenBetter(db);
    for( City* c in cities){
      printf("%s\n", [[c description] UTF8String]);
    }
    sqlite3_close(db);

  }
    return 0;
}

