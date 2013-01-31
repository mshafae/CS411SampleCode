// $Id: userdefaults.m 3143 2011-09-19 09:56:06Z mshafae $
// Saves its database to ~/Library/Preferences/progname.plist
#import <Foundation/Foundation.h>
#import <assert.h>

int main( void ){
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults retain];
  
  if( [defaults stringForKey: @"demo"] == nil ){
    NSLog( @"Nothing found for key 'demo'" );
    [defaults setObject: @"CS 491T" forKey: @"demo"];
    [defaults synchronize];
  }else{
    NSLog( @"the string: %@", [defaults stringForKey: @"demo"] );
    [defaults removeObjectForKey: @"demo" ];
    [defaults synchronize];
  }

  [defaults release];
  [pool release];
  return( 0 );  
}
