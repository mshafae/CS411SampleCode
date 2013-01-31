// $Id: simpleclass.m 3840 2012-10-16 02:10:32Z mshafae $

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
  NSString* _name;
}

@property (retain) NSString* name;

-(id) initWithName:(NSString*) aName;

-(void) setName:(NSString*) aName;

-(NSString*) name;

@end

@implementation Person
-(id) initWithName:(NSString*) aName
{
  [super init];
  if( self != nil ){
    _name = [aName retain];
  }
  return self;
}

-(NSString*) name
{
  return _name;
}

-(void) setName:(NSString*) aName
{
  if( _name != aName ){
    NSString* oldName = _name;
    _name = [aName retain];
    [oldName release];
  }
}

/* Alternatives:
-(void) setName:(NSString*) aName
{
  [_name autorelease];
  _name = [aName retain];
}
or
-(void) setName:(NSString*) aName
{
  if( _name == aName ){
  return
  }
  NSString* oldName = _name;
  _name = [aName retain];
  [oldName release];
}
*/
@end

int main(void){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  Person *p = [[[Person alloc] initWithName:@"Timmy"] retain];
  NSLog(@"%@", p.name);
  p.name = @"Sveta";
  NSLog(@"%@", p.name);
  [p setName: @"Jane"];
  NSLog(@"%@", p.name);
  [p release];
  [pool release];
  return( 0 );  
}