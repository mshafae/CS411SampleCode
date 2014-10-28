// $Id: synthesize_example.m 3027 2011-08-08 04:04:11Z mshafae $
// cc -framework Foundation property_example.m
#import <Foundation/Foundation.h>
#include <math.h>

@interface Obj : NSObject
{
@private
  int x;
  char c;
}
@property int x;
@property char c;

@end

@implementation Obj
@synthesize x;
@synthesize c;
@end

int main( int argc, char **argv ){
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  Obj *a = [[Obj alloc] init];
  a.x = 14;
  a.c = 'r';
  NSLog( @"%d %c", a.x, a.c );
  a.x++;
  NSLog( @"%d %c", a.x, a.c );
  [pool release];
  return(0);
}