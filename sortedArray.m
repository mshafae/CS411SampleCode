// $Id: sortedArray.m 4079 2013-02-13 23:23:58Z mshafae $

#import <Foundation/Foundation.h>

@interface DirectoryEntry : NSObject
{
  NSString* _phoneNumber;
}
@property (nonatomic, retain) NSString* phoneNumber;
- (id) initWithPhoneNumber: (NSString*) aPhoneNumber;
@end
@implementation DirectoryEntry
@synthesize phoneNumber = _phoneNumber;
- (id) initWithPhoneNumber: (NSString*) aPhoneNumber
{
  [super init];
  if( self ){
    self.phoneNumber = aPhoneNumber;
  }
  return self;
}
- (id) copyWithZone: (NSZone *) zone
{
  // Since NSObject doesn't implement NSCopying this is OK
  DirectoryEntry* copy = [[[self class] allocWithZone: zone] initWithPhoneNumber: self.phoneNumber];
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
      NSLog(@"%@", (NSString*)word);
    }
    NSLog(@"sorted:");
    for( id word in sortedFirstLineOfAnnaKarenina ){
      NSLog(@"%@", (NSString*)word);
    }
    DirectoryEntry* e = [[DirectoryEntry alloc] initWithPhoneNumber:@"650-433-3490"];
    NSMutableArray* directory = [[NSMutableArray alloc] init];
    [directory addObject: [e copy]];
    e.phoneNumber = @"415-678-9345";
    [directory addObject: [e copy]];
    e.phoneNumber = @"403-255-1212";
    [directory addObject: [e copy]];
    e.phoneNumber = @"403-211-5346";
    [directory addObject: [e copy]];
    NSSortDescriptor* phoneNumberSortDescriptor = [NSSortDescriptor sortDescriptorWithKey: @"phoneNumber" ascending: YES];
    NSArray* arrayOfSortDescriptors = @[phoneNumberSortDescriptor];
    NSArray* sortedDirectory = [directory sortedArrayUsingDescriptors: arrayOfSortDescriptors];
    NSLog(@"original:");
    for( id entry in directory ){
      NSLog(@"%@", ((DirectoryEntry*)entry).phoneNumber);
    }
    NSLog(@"sorted:");
    for( id entry in sortedDirectory ){
      NSLog(@"%@", ((DirectoryEntry*)entry).phoneNumber);
    }
    
    return 0;
  }
}