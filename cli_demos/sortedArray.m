// $Id: sortedArray.m 4081 2013-02-14 08:27:44Z mshafae $

#import <Foundation/Foundation.h>

@interface DirectoryEntry : NSObject
{
  NSString* _phoneNumber;
  NSString* _firstName;
  NSString* _lastName;
}
@property (nonatomic, retain) NSString* phoneNumber;
@property (nonatomic, retain) NSString* firstName;
@property (nonatomic, retain) NSString* lastName;
- (id) initWithPhoneNumber: (NSString*) aPhoneNumber FirstName: (NSString*) aFirstName LastName: (NSString*) aLastName;
@end
@implementation DirectoryEntry
@synthesize phoneNumber = _phoneNumber;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
- (id) initWithPhoneNumber: (NSString*) aPhoneNumber FirstName: (NSString*) aFirstName LastName: (NSString*) aLastName
{
  [super init];
  if( self ){
    self.phoneNumber = aPhoneNumber;
    self.firstName = aFirstName;
    self.lastName = aLastName;
  }
  return self;
}
- (NSString*) description
{
  return [NSString stringWithFormat: @"%@, %@: %@", self.lastName, self.firstName, self.phoneNumber];
}
- (id) copyWithZone: (NSZone *) zone
{
  // Since NSObject doesn't implement NSCopying this is OK
  DirectoryEntry* copy = [[[self class] allocWithZone: zone] initWithPhoneNumber: self.phoneNumber FirstName: self.firstName LastName: self.lastName];
  return copy;
}
@end

int main( void ){
  @autoreleasepool{
    NSString* firstLineOfAnnaKarenina = @"Happy families are all alike every unhappy family is unhappy in its own way";
    NSArray* arrayOfWords = [firstLineOfAnnaKarenina componentsSeparatedByString: @" "];
    NSArray* sortedFirstLineOfAnnaKarenina = [arrayOfWords sortedArrayUsingSelector:@selector(compare:)];
    NSLog(@"original:");
    for( id word in arrayOfWords ){
      NSLog(@"%@", word);
    }
    NSLog(@"sorted:");
    for( id word in sortedFirstLineOfAnnaKarenina ){
      NSLog(@"%@", word);
    }
    DirectoryEntry* e = [[DirectoryEntry alloc] initWithPhoneNumber:@"650-433-3490" FirstName: @"Joe" LastName: @"DiMaggio"];
    NSMutableArray* directory = [[NSMutableArray alloc] init];
    [directory addObject: [e copy]];
    e.phoneNumber = @"415-678-9345";
    e.lastName = @"DeMarco";
    [directory addObject: [e copy]];
    e.phoneNumber = @"403-255-1212";
    e.firstName = @"Abby";
      e.lastName = @"Singleton";
    [directory addObject: [e copy]];
    e.phoneNumber = @"403-211-5346";
    e.firstName = @"Fred";
    e.lastName = @"Flintstone";
    [directory addObject: [e copy]];
  NSSortDescriptor* phoneNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey: @"phoneNumber" ascending: YES];
  NSSortDescriptor* lastNameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey: @"lastName" ascending: YES];
    NSArray* arrayOfSortDescriptors = @[lastNameSortDescriptor, phoneNumberSortDescriptor];
    NSArray* sortedDirectory = [directory sortedArrayUsingDescriptors: arrayOfSortDescriptors];
    NSLog(@"original:");
    for( id entry in directory ){
      NSLog(@"%@", [entry description]);
    }
    NSLog(@"sorted:");
    for( id entry in sortedDirectory ){
      NSLog(@"%@", [entry description]);
    }
    
    return 0;
  }
}