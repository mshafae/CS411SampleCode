// $Id$
// cc corelocation_demo.m -framework CoreLocation -framework Foundation
#import <stdio.h>
#import <stdlib.h>
#import <CoreLocation/CoreLocation.h>
#import <Cocoa/Cocoa.h>

@interface CLLocation (Strings)
- (NSString *) localizedCoordinateString;
- (NSString *) localizedAltitudeString;
- (NSString *) localizedHorizontalAccuracyString;
- (NSString *) localizedVerticalAccuracyString;
@end

@implementation CLLocation (Strings)
- (NSString *)localizedCoordinateString {
    if (self.horizontalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    NSString *latString = (self.coordinate.latitude < 0) ? NSLocalizedString(@"South", @"South") : NSLocalizedString(@"North", @"North");
    NSString *lonString = (self.coordinate.longitude < 0) ? NSLocalizedString(@"West", @"West") : NSLocalizedString(@"East", @"East");
    return [NSString stringWithFormat:NSLocalizedString(@"LatLongFormat", @"LatLongFormat"), fabs(self.coordinate.latitude), latString, fabs(self.coordinate.longitude), lonString];
}
- (NSString *)localizedAltitudeString {
    if (self.verticalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    NSString *seaLevelString = (self.altitude < 0) ? NSLocalizedString(@"BelowSeaLevel", @"BelowSeaLevel") : NSLocalizedString(@"AboveSeaLevel", @"AboveSeaLevel");
    return [NSString stringWithFormat:NSLocalizedString(@"AltitudeFormat", @"AltitudeFormat"), fabs(self.altitude), seaLevelString];
}
- (NSString *)localizedHorizontalAccuracyString {
    if (self.horizontalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"AccuracyFormat", @"AccuracyFormat"), self.horizontalAccuracy];
}
- (NSString *)localizedVerticalAccuracyString {
    if (self.verticalAccuracy < 0) {
        return NSLocalizedString(@"DataUnavailable", @"DataUnavailable");
    }
    return [NSString stringWithFormat:NSLocalizedString(@"AccuracyFormat", @"AccuracyFormat"), self.verticalAccuracy];
}    
@end


@interface MyLocationManager : NSObject <CLLocationManagerDelegate>
@property (nonatomic, retain) NSMutableArray* locationMeasurements;
@property (nonatomic, retain) CLLocationManager* locationManager;
@property (nonatomic, retain) NSString* stateString;
@property (nonatomic, retain) CLLocation* bestEffortAtLocation;
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void) startUpdatingLocation:(NSString *)state;
- (void) stopUpdatingLocation:(NSString *)state;
@end

@implementation MyLocationManager
@synthesize locationMeasurements;
@synthesize locationManager;
@synthesize stateString;
@synthesize bestEffortAtLocation;
- (id) init
{
  self = [super init];
  if( self ){
    locationMeasurements = [[NSMutableArray alloc] init];
  }
  return self;
}
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationMeasurements addObject:newLocation];
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) return;
    if (newLocation.horizontalAccuracy < 0) return;
    if (self.bestEffortAtLocation == nil || self.bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        self.bestEffortAtLocation = newLocation;
        if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            [self stopUpdatingLocation:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocation:) object:nil];
        }
    }
}
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocation:@"Error"];
    }
}
- (void) startUpdatingLocation:(NSString *)state
{
  NSLog(@"Starting.");
  self.stateString = state;
  self.locationManager = [[[CLLocationManager alloc] init] autorelease];
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = 100.0;
  [self.locationManager startUpdatingLocation];
  [self performSelector:@selector(stopUpdatingLocation:) withObject:@"Timed Out" afterDelay:20.0];
  self.stateString = NSLocalizedString(@"Updating", @"Updating");
}

- (void) stopUpdatingLocation:(NSString *)state
{
  self.stateString = state;
  [self.locationManager stopUpdatingLocation];
  self.locationManager.delegate = nil;
  NSLog(@"The state is %@", self.stateString);
  NSLog(@"The coordinates %@", [self.bestEffortAtLocation localizedCoordinateString]);
  NSLog(@"The altitude %@", self.bestEffortAtLocation.localizedAltitudeString);
  NSLog(@"The horizontal accuracy string %@", self.bestEffortAtLocation.localizedHorizontalAccuracyString);
}
@end


int main( void ){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  if ([CLLocationManager locationServicesEnabled] == NO) {
    NSLog(@"Location services are not enabled. Exiting.");
    exit(1);
  }
  MyLocationManager* mlm = [[MyLocationManager alloc] init];
  [mlm startUpdatingLocation:@"Starting"];
[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:25]];
  [pool release];
  return(0);
}