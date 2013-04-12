//
//  USLocationsDatabase.h
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MSAphorism.h"

@interface FortuneDatabase : NSObject
{
  sqlite3* _databaseConnection;
  unsigned int _count;
  unsigned int _counter;
  unsigned int* _shuffle;
}

+ (FortuneDatabase*) database;
- (MSAphorism*) next;

@end
