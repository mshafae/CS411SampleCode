// $Id: property_example.m 3840 2012-10-16 02:10:32Z mshafae $
// cc -framework Foundation property_example.m
#import <Foundation/Foundation.h>
#include <math.h>

@interface boolObj : NSObject
{
@private
  BOOL enabled;
}
@property (nonatomic, readonly, getter=isEnabled) BOOL enabled;
@end
@implementation boolObj
@synthesize enabled
@end

@interface OtherObj : NSObject
{
@private
  NSString* str;
}
-(NSString*) str;
-(void) setStr: (NSString*)aStr;
@end

@implementation OtherObj
-(NSString*) str
{
  return str
}

-(void) setStr: (NSString*)aStr
{
  [str autorelease];
  str = [aStr retrain];
}

-(void) setStr: (NSString*)aStr
{
  /*
  [str autorelease];
  str = [aStr retrain];
  */
  if( str == aStr ){
    return;
  }
  NSString* oldValue = str;
  str = [aStr retain];
  [oldValue release];
  /*
   * If the same obj, this is problematic
   [str release];
   str = [aStr retain];
   */
}



#ifdef OLDWAY
@interface Obj : NSObject
{
@private
  int x;
  char c;
}

- (int) x;
- (void) setX: (int) anInt;
- (char) c;
- (void) setC: (char) aChar;
@end

@implementation Obj
- (int) x
{
  return(x);
}
- (void) setX: (int) anInt
{
  x = anInt;
}
- (char) c
{
  return(c);
}
- (void) setC: (char) aChar
{
  c = aChar;
}

@end
#endif

#ifdef NEWWAY
@interface Obj : NSObject
{
@private
  int x;
  char c;
}
@property int x;
@property (readonly) char c;
@property (readonly) double pi;
- (void) secretSetC: (char) aChar;
@end

@implementation Obj
- (void) secretSetC: (char) aChar
{
  c = aChar;
}
- (double) pi
{
  return(M_PI);
}
- (int) x
{
  return(x);
}
- (void) setX: (int) anInt
{
  x = anInt;
}
- (char) c
{
  return(c);
}

@end
#endif
int main( int argc, char **argv ){
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  Obj *a = [[Obj alloc] init];
  a.x = 14;
#ifdef OLDWAY
  a.c = 'r';
#endif
#ifdef NEWWAY
  [a secretSetC: 'q'];
  NSLog( @"%g", a.pi );
#endif
  NSLog( @"%d %c", a.x, a.c );
  a.x++;
  NSLog( @"%d %c", a.x, a.c );
  [pool release];
  return(0);
}
