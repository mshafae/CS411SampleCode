// $Id: dynamic_binding.m 3142 2011-09-19 09:42:50Z mshafae $

#import <Foundation/Foundation.h>

@interface Person : NSObject
- (void) doSomething;
@end
@implementation Person
- (void) doSomething
{
  NSLog( @"Person does something" );
}
@end

@interface Clown : Person
- (void) clownAround;
@end
@implementation Clown
- (void) clownAround
{
  NSLog( @"how many clowns can come out of a Fiat 500?" );
}
@end

@interface HoboClown : Clown
- (void) fallDown;
@end
@implementation HoboClown
- (void) fallDown
{
  NSLog( @"woops, the hobo clown fell down" );
}
@end

@interface Hobo : Person
- (void) hopATrain;
@end
@implementation Hobo
- (void) hopATrain
{
  NSLog( @"eating beans on a train" );
}
@end

int main( void ){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  id foo;
  Person *p = [[Person alloc] init];
  [p retain];
  Clown *c = [[Clown alloc] init];
  [c retain];
  HoboClown *hc = [[HoboClown alloc] init];
  [hc retain];
  Hobo *h = [[Hobo alloc] init];
  [h retain];
  
  NSLog( @"Address: p = %p, c = %p", &p, &c );
  NSLog( @"Points to: p = %p, c = %p", p, c );
  
  [p doSomething];
  [c clownAround];
  [c release];
  c = p;
  [c retain];
  [c doSomething];
  NSLog( @"Address: p = %p, c = %p", &p, &c );
  NSLog( @"Points to: p = %p, c = %p", p, c );

  [hc fallDown];
  // This will cause a crash
  //[hc hopATrain];
  
  foo = hc;
  [foo retain];
  [foo fallDown];
  NSLog( @"Address: foo = %p, hc = %p", &foo, &hc );
  NSLog( @"Points to: foo = %p, hc = %p", foo, hc );

  // Is the class related to a class
  if( [foo isKindOfClass: [Person class]] ){
    NSLog( @"%@ is kind of %@", [foo description], [Person class] );
  }else{
    NSLog( @"%@ is not kind of %@", [foo description], [Person class] );
  }
  if( [foo isKindOfClass: [Hobo class]] ){
    NSLog( @"%@ is kind of %@", [foo description], [Hobo class] );
  }else{
    NSLog( @"%@ is not kind of %@", [foo description], [Hobo class] );
  }

  // Check to see if the object is a particular class
  if( [foo isMemberOfClass: [Person class]] ){
    NSLog( @"%@ is member of %@", [foo description], [Person class] );
  }else{
    NSLog( @"%@ is not member of %@", [foo description], [Person class] );
  }
  if( [foo isMemberOfClass: [HoboClown class]] ){
    NSLog( @"%@ is member of %@", [foo description], [HoboClown class] );
    [(HoboClown*)foo fallDown];
  }else{
    NSLog( @"%@ is not member of %@", [foo description], [HoboClown class] );
  }
  
  if( [foo respondsToSelector: @selector(hopATrain) ] == NO ){
    NSLog( @"%@ does not respond to selector %@", [foo description], @"hopATrain" );
  }else{
    NSLog( @"%@ does respond to selector %@", [foo description], @"hopATrain" );
    [foo hopATrain];
  }
  
  if( [foo respondsToSelector: @selector(doSomething) ] == NO ){
    NSLog( @"%@ does not respond to selector %@", [foo description], @"doSomething" );
  }else{
    NSLog( @"%@ does respond to selector %@", [foo description], @"doSomething" );
    [foo doSomething];
    SEL fallDownSelector = @selector( fallDown );
    [foo performSelector: fallDownSelector ];
  }
  [foo release];
  [p release];
  [c release];
  [hc release];
  [h release];
  [pool release];
  return( 0 );  
}