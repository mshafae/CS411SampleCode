// $Id: dictionarycoder.m 5682 2015-04-10 04:55:52Z mshafae $

#import <Foundation/Foundation.h>

@interface ISO4217Currency : NSObject <NSSecureCoding, NSObject>

@property (retain, nonatomic) NSString* country;
@property (retain, nonatomic) NSString* currency;
@property (retain, nonatomic) NSString* alphaCode;

-(ISO4217Currency*) initWithCountry: (NSString*) aCountry Currency: (NSString*) aCurrency AlphaCode:(NSString*) anAlphaCode;

-(ISO4217Currency*) initWithCoder: (NSCoder*) aDecoder;

-(void) encodeWithCoder: (NSCoder*) anEncoder;
@end

@implementation ISO4217Currency

@synthesize country;
@synthesize currency;
@synthesize alphaCode;

+(BOOL) supportsSecureCoding
{
  return YES;
}

-(ISO4217Currency*) initWithCountry: (NSString*) aCountry Currency: (NSString*) aCurrency AlphaCode:(NSString*) anAlphaCode
{
  self = [super init];
  if (self) {
    country = aCountry;
    currency = aCurrency;
    alphaCode = anAlphaCode;
  }
  return self;
}

-(ISO4217Currency*) initWithCoder: (NSCoder*) aDecoder
{
  self = [super init];
  if(self){
    self.country = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"country"];
    self.currency = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"currency"];
    self.alphaCode = [aDecoder decodeObjectOfClass: [ISO4217Currency class] forKey: @"alphaCode"];
  }
  return self;
}

-(void) encodeWithCoder: (NSCoder*) anEncoder
{
  [anEncoder encodeObject: self.country forKey: @"country"];
  [anEncoder encodeObject: self.currency forKey: @"currency"];
  [anEncoder encodeObject: self.alphaCode forKey: @"alphaCode"];
}

-(NSString*) description
{
  return [NSString stringWithFormat: @"%@ %@ %@", self.country, self.currency, self.alphaCode];
}

@end

int main(void){
  @autoreleasepool{
    ISO4217Currency* azerbaijanCurrency = [[ISO4217Currency alloc] initWithCountry: @"AZERBAIJAN" Currency: @"Azerbaijanian Manat" AlphaCode: @"AZN"];
    ISO4217Currency* chileCurrency = [[ISO4217Currency alloc] initWithCountry: @"CHILE" Currency: @"Chilean Peso" AlphaCode: @"CLP"];
    ISO4217Currency* kiribatiCurrency = [[ISO4217Currency alloc] initWithCountry: @"KIRIBATI" Currency: @"Australian Dollar" AlphaCode: @"AUD"];
    ISO4217Currency* nicaraguaCurrency = [[ISO4217Currency alloc] initWithCountry: @"NICARAGUA" Currency: @"Cordoba Oro" AlphaCode: @"NIO"];

    NSArray* currencies = @[azerbaijanCurrency, chileCurrency, kiribatiCurrency, nicaraguaCurrency];

    NSArray* keys = @[azerbaijanCurrency.alphaCode, chileCurrency.alphaCode, kiribatiCurrency.alphaCode, nicaraguaCurrency.alphaCode];

    for(ISO4217Currency* i in currencies){
      NSLog(@"From the array: (%p) %@", i, [i description]);
    }

    puts("\n");

    NSDictionary* currencyDictionary = [NSDictionary dictionaryWithObjects: currencies forKeys: keys];
    
    for(NSString* k in keys){
      ISO4217Currency* i = [currencyDictionary objectForKey: k];
      NSLog(@"From the dictionary: (%p) %@", i, [i description]);
    }

    puts("\n");
    
    NSString* archiveFile = @"/tmp/currency.plist";

    if( [NSKeyedArchiver archiveRootObject: currencyDictionary toFile: archiveFile] ){
      NSLog(@"Wrote dictionary to %@", archiveFile);
    }else{
      NSLog(@"Failed to write dictionary.");
      exit(1);
    }
    
    NSDictionary* newCurrencyDictionary = nil;
    if( (newCurrencyDictionary = [NSKeyedUnarchiver unarchiveObjectWithFile: archiveFile]) != nil ){
      NSLog(@"Read dictionary stored in %@", archiveFile);
    }else{
      NSLog(@"Failed to read dictionary.");
      exit(1);
    }
    
    for(NSString* k in newCurrencyDictionary.allKeys){
      ISO4217Currency* i = [newCurrencyDictionary objectForKey: k];
      NSLog(@"From the dictionary: (%p) %@", i, [i description]);
    }
        
  }
  return 0;
}
