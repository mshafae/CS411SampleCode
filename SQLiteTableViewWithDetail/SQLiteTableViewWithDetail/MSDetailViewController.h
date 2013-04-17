//
//  MSDetailViewController.h
//  SQLiteTableViewWithDetail
//
//  Created by Michael Shafae on 4/16/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location.h"

@interface MSDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) Location* location;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *coordLabel;
@property (weak, nonatomic) IBOutlet UILabel *populationLabel;
@end
