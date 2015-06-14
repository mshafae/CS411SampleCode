// $Id: Singleton.m 5302 2014-10-28 09:06:19Z mshafae $

#import <Foundation/Foundation.h>

// Singleton.h
@interface Singleton : NSObject
@property (retain, nonatomic) NSString* name;
@end

// Singleton.m
static Singleton* _sharedSingletonInstance;
@implementation Singleton
@synthesize name;

-(Singleton*) init
{
	self = [super init];
	if( self ){
		name = @"I'm a singleton";
	}
	return self;
}

-(NSString*) description
{
	return [NSString stringWithFormat: @"%@ (%p)", self.name, self];
}

+(void) initialize
{
	if( [Singleton class] == self ){
		_sharedSingletonInstance = [self new];
	}
}

+(Singleton*) sharedSingletonInstance
{
	return _sharedSingletonInstance;
}

+(id) allocWithZone: (NSZone*) aZone
{
	if( _sharedSingletonInstance && [Singleton class] == self ){
		[NSException raise: NSGenericException format: @"May not create more than one instance of a singleton class!"];
	}
	return [super allocWithZone: aZone];
}

@end

int main(void){
	@autoreleasepool{
		Singleton *a, *b;
		a = [Singleton sharedSingletonInstance];
		NSLog(@"%@", [a description]);
		b = [Singleton sharedSingletonInstance];
		NSLog(@"%@", [b description]);
		// This line will fail if you uncomment it.
		//Singleton *c = [[Singleton alloc] init];
	}
	return 0;
}