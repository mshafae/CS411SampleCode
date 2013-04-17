//
//  MSDetailViewController.m
//  SQLiteTableViewWithDetail
//
//  Created by Michael Shafae on 4/16/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import "MSDetailViewController.h"

@interface MSDetailViewController ()

@end

@implementation MSDetailViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.cityLabel.text = self.location.accentCity;
  self.populationLabel.text = [self.location.population stringValue];
  self.coordLabel.text = [NSString stringWithFormat: @"%@, %@", self.location.latitudeString, self.location.longitudeString];
  [self.map setCenterCoordinate: self.location.coord animated: YES];
  self.map.region = MKCoordinateRegionMake(self.location.coord, MKCoordinateSpanMake(0.5, 0.5));
  MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
  [annotation setCoordinate: self.location.coord];
  [annotation setTitle: self.location.accentCity];
  [self.map addAnnotation:annotation];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
  [self setCoordLabel:nil];
  [self setPopulationLabel:nil];
  [super viewDidUnload];
}
@end
