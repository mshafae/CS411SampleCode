//
//  ViewController.m
//  SaveAnArchive
//
//  Created by Michael Shafae on 4/10/15.
//  Copyright (c) 2015 Michael Shafae. All rights reserved.
//

#import "ViewController.h"
#import "ISO4217Currency.h"

@interface ViewController ()

@end

@implementation ViewController

// Inspired by and gratuitously stolen from Apple's File System Programming Guide
// https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/
- (NSURL*)applicationDataDirectory {
  NSFileManager* sharedFM = [NSFileManager defaultManager];
  NSArray* possibleURLs = [sharedFM URLsForDirectory:NSApplicationSupportDirectory
                                           inDomains:NSUserDomainMask];
  NSURL* appSupportDir = nil;
  NSURL* appDirectory = nil;
  
  if ([possibleURLs count] >= 1) {
    for(NSURL* u in possibleURLs){
      NSLog(@"possible URL: %@", [u description]);
    }
    // Use the first directory (if multiple are returned)
    appSupportDir = [possibleURLs objectAtIndex:0];
  }
  
  NSLog(@"The application support directory is %@", appSupportDir.description);
  
  // If a valid app support directory exists, add the
  // app's bundle ID to it to specify the final directory.
  if (appSupportDir) {
    NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
    appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
  }
  
  NSLog(@"The path selected is %@", appDirectory.path);

  BOOL isDirectory;
  if( [sharedFM fileExistsAtPath: appDirectory.path isDirectory: &isDirectory] == YES ){
    NSLog(@"The path exists and it %@ a directory.", isDirectory ? @"is" : @"is not" );
  }else{
    NSLog(@"The path does not exist!!! Let's create it.");
  }

  [sharedFM createDirectoryAtPath: appDirectory.path withIntermediateDirectories: YES attributes: nil error: nil];
  if( [sharedFM fileExistsAtPath: appDirectory.path isDirectory: &isDirectory] == YES ){
    NSLog(@"The path exists and it %@ a directory.", isDirectory ? @"is" : @"is not" );
  }else{
    NSLog(@"The path still does not exist!!! exiting.");
    exit(1);
  }

  return appDirectory;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  ISO4217Currency* azerbaijanCurrency = [[ISO4217Currency alloc] initWithCountry: @"AZERBAIJAN" Currency: @"Azerbaijanian Manat" AlphaCode: @"AZN"];
  ISO4217Currency* chileCurrency = [[ISO4217Currency alloc] initWithCountry: @"CHILE" Currency: @"Chilean Peso" AlphaCode: @"CLP"];
  ISO4217Currency* kiribatiCurrency = [[ISO4217Currency alloc] initWithCountry: @"KIRIBATI" Currency: @"Australian Dollar" AlphaCode: @"AUD"];
  ISO4217Currency* nicaraguaCurrency = [[ISO4217Currency alloc] initWithCountry: @"NICARAGUA" Currency: @"Cordoba Oro" AlphaCode: @"NIO"];
  
  NSArray* currencies = @[azerbaijanCurrency, chileCurrency, kiribatiCurrency, nicaraguaCurrency];
  
  NSArray* keys = @[azerbaijanCurrency.alphaCode, chileCurrency.alphaCode, kiribatiCurrency.alphaCode, nicaraguaCurrency.alphaCode];
  
  NSDictionary* currencyDictionary = [NSDictionary dictionaryWithObjects: currencies forKeys: keys];
  
  NSString* path = [self applicationDataDirectory].path;
  

  NSString* archiveFile = [path stringByAppendingString: @"/dictArchive.plist"];

  NSLog(@"Attempting to write to %@", archiveFile);
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

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
