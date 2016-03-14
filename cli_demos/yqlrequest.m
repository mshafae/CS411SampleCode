//
// $Id$
//

#import <Foundation/Foundation.h>


int main(void){
  @autoreleasepool{
    char in[64];
    puts("Please enter your currency code\n");
    scanf("%s", in);
    printf("You typed \"%s\"\n", in);
    NSString* inCode = [NSString stringWithCString: in encoding: NSASCIIStringEncoding];
    NSLog(@"is it still %@?", inCode);
    NSNumber* rate;
    NSDate *lastFetchedOn;
    NSString* yqlQuery = [NSString stringWithFormat: @"select * from yahoo.finance.xchange where pair in (\"%@%@\")", @"USD", inCode];
    NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=%@&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", [yqlQuery stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding]];
    NSLog(@"The url is %@", urlString);
    NSURL *yahooFinanaceRESTQueryURL = [NSURL URLWithString: urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: yahooFinanaceRESTQueryURL];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSLog(@"Starting request...");
    NSData *yahooFinanaceQueryResults = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
    NSLog(@"...finished!");
    if( response.statusCode == 200 ){
      NSLog(@"Successful request!");
      id unknownObject = [NSJSONSerialization
                          JSONObjectWithData: yahooFinanaceQueryResults
                          options: 0
                          error: &error];
      NSDictionary *exchangeRatesDictionary;
  
      if (!error) {
        NSLog(@"Loaded JSON Data Successfully");
        if( [unknownObject isKindOfClass: [NSDictionary class]]){
          NSLog(@"It's a dictionary!");
          exchangeRatesDictionary = unknownObject;
          NSDictionary *result = [[[exchangeRatesDictionary valueForKey: @"query"] valueForKey:@"results"] valueForKey: @"rate"];
          rate = [NSNumber numberWithFloat: [[result objectForKey: @"Rate"] floatValue]];
          lastFetchedOn = [NSDate date];
        }else{
          exchangeRatesDictionary = nil;
          return 1;
        }
      }else{
        NSLog(@"There was an unfortunate error; nothing was loaded.");
        return 1;
      }
    }else{
      // response.statusCode != 200 (400? 500?)
      NSLog(@"Could not fetch exchange rate. %@", error.description);
    }
    NSLog(@"USD to %@ rate is %@ fetched on %@", inCode, rate, lastFetchedOn);
  }
  return 0;
}