//
//  SQLTableViewController.h
//  SQLiteTableView
//
//  Created by Michael Shafae on 11/8/12.
//  Copyright (c) 2012 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "CitiesDatabase.h"

@interface SQLTableViewController : UITableViewController
{
  NSArray* _locations;
}

@property (nonatomic, retain) NSArray* locations;

@end
