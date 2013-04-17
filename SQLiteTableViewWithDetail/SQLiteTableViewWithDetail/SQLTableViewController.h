//
//  MSViewController.h
//  SQLiteTableViewWithDetail
//
//  Created by Michael Shafae on 4/16/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "CitiesDatabase.h"

@interface SQLTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
  NSArray* _locations;
}

@property (nonatomic, retain) NSArray* locations;

@end
