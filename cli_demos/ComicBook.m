// $Id$

#import <Foundation/Foundation.h>

@interface ComicBook : NSObject
{
  NSString* _title;
  unsigned int _issue;
}

-(id) initWithTitle: (NSString*)aTitle andIssue: (unsigned int)anIssue;
-(NSString*) title;
-(void) setTitle: (NSString*)aTitle;
-(unsigned int) issue;
-(void) setIssue: (unsigned int)anIssue;
@end

@implementation ComicBook
-(id) initWithTitle: (NSString*)aTitle andIssue: (unsigned int)anIssue
{
  [super init];
  if( self ){
    _title = [aTitle retain];
    _issue = anIssue;
  }
  return self;
}

-(NSString*) title
{
  return _title;
}

-(void) setTitle: (NSString*)aTitle
{
  if( _title != aTitle ){
    NSString* oldTitle = _title;
    _title = [aTitle retain];
    [oldTitle release];
  }
}

-(unsigned int) issue
{
  return _issue;
}

-(void) setIssue: (unsigned int)anIssue
{
  _issue = anIssue;
}
@end

int main( void ){
  ComicBook* c = [[ComicBook alloc] initWithTitle: @"SpiderMan" andIssue: 200];
  NSLog( @"The title is %@", [c title]);
  NSLog( @"The issue is %u", [c issue]);
  [c setTitle: @"X-Men"];
  [c setIssue: 300];
  NSLog( @"The title is %@", [c title]);
  NSLog( @"The issue is %u", [c issue]);
  return 0;
}
