#import <Foundation/Foundation.h>

@interface ExchangeRate : NSObject
@property (strong) NSString* homeCurrency;
@property (strong) NSString* foreignCurrency;

-(ExchangeRate*) initWithHomeCurrency: (NSString*) aHomeCurrency foreignCurrency: (NSString*) aForeignCurrency;
-(NSURL*) exchangeRateURL;
+(NSArray*) allExchangeRates;

@end
@implementation ExchangeRate
@synthesize foreignCurrency;
@synthesize homeCurrency;

-(ExchangeRate*) initWithHomeCurrency: (NSString*) aHomeCurrency foreignCurrency: (NSString*) aForeignCurrency
{
  self = [super init];
  if(self){
    foreignCurrency = aForeignCurrency;
    homeCurrency = aHomeCurrency;
  }
  return self;
}

-(NSString*) description
{
  return [NSString stringWithFormat: @"%@ %@", self.homeCurrency, self.foreignCurrency];
}

-(NSURL*) exchangeRateURL
{
  NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%@%%22)&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", self.homeCurrency, self.foreignCurrency];
  return [NSURL URLWithString: urlString];
}

+(NSArray*) allExchangeRates
{
  NSMutableArray* allRates = [[NSMutableArray alloc] init];
  [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"GBP"]];
  [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"JPY"]];
  [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"MXN"]];
  [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"EUR"]];
  [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"CAD"]];
  return (NSArray*)allRates;
}
@end
@interface URLFetcherExample : NSObject
-(void) fetch;
@end
@interface URLFetcherExample ()
@property (strong) NSMutableDictionary *completionHandlerDictionary;
@property (strong) NSURLSessionConfiguration *ephemeralConfigObject;
@end

@implementation URLFetcherExample
@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;

-(URLFetcherExample*) init
{
  self = [super init];
  if(self){
    completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
  }
  return self;
}

-(void) fetch
{
  NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
  NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
  for(ExchangeRate* i in [ExchangeRate allExchangeRates]){
    NSLog(@"dispatching %@", [i description]);
    NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [i exchangeRateURL]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                          NSLog(@"Got response %@ with error %@.\n", response, error);
                          NSLog(@"DATA:\n%@\nEND DATA\n",
                                [[NSString alloc] initWithData: data
                                                      encoding: NSUTF8StringEncoding]);
                        }];
    [task resume];
  }
}
@end
int main(int argc, const char * argv[]) {
  @autoreleasepool {
    SInt32 res = 0;
    URLFetcherExample* f = [[URLFetcherExample alloc] init];
    [f fetch];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
  }
    return 0;
}
