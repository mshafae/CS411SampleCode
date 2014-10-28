// $Id: foreach.m 3142 2011-09-19 09:42:50Z mshafae $

#import <Foundation/Foundation.h>
#import <assert.h>

int main( void ){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  NSDictionary *dict;
  NSArray *a;
  NSEnumerator *enumerator;
  id obj;
  dict = [NSDictionary dictionaryWithContentsOfFile: @"demo.plist" ];
  assert( dict != nil );
  a = [dict allValues];
  enumerator = [a objectEnumerator];
  while( (obj = [enumerator nextObject]) != nil ){
    NSLog( @"Next Object is: %@", obj );
    if( [obj isKindOfClass:[NSNumber class]] ){
      NSLog( @"it is a number! %g", [(NSNumber*)obj doubleValue] );
    }else if( [obj isKindOfClass:[NSString class]] ){
      NSLog( @"its is a string! %@", (NSString*)obj );
    }else{
      if( [obj respondsToSelector: @selector(description)] ){
        NSLog( @"its not a number or a string %@", [obj description] );
      }else{
        NSLog( @"its not a number or a string" );
      }
    }
  }

  for( id key in dict ){
    obj = [dict objectForKey: key];
    NSLog( @"Next Object is: %@", obj );
    if( [obj isKindOfClass:[NSNumber class]] ){
      NSLog( @"it is a number! %g", [(NSNumber*)obj doubleValue] );
    }else if( [obj isKindOfClass:[NSString class]] ){
      NSLog( @"its is a string! %@", (NSString*)obj );
    }else{
      if( [obj respondsToSelector: @selector(description)] ){
        NSLog( @"its not a number or a string %@", [obj description] );
      }else{
        NSLog( @"its not a number or a string" );
      }
    }
  }  

  [pool release];
  return( 0 );  
}