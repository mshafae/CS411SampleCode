// $Id: helloworld.m 3841 2012-10-16 02:29:57Z mshafae $

#import <Foundation/Foundation.h>

int main( void ){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  NSLog(@"Hello World!");
  [pool release];
  return( 0 );  
}


//Alternative
int mainx( void ){
  @autoreleasepool{
  NSLog(@"Hello World!");
  }
  return( 0 );  
}
