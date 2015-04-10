//
//  ISO4217Currency.h
//  SaveAnArchive
//
//  Created by Michael Shafae on 4/10/15.
//  Copyright (c) 2015 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISO4217Currency : NSObject <NSSecureCoding, NSObject>

@property (retain, nonatomic) NSString* country;
@property (retain, nonatomic) NSString* currency;
@property (retain, nonatomic) NSString* alphaCode;

-(ISO4217Currency*) initWithCountry: (NSString*) aCountry Currency: (NSString*) aCurrency AlphaCode:(NSString*) anAlphaCode;

-(ISO4217Currency*) initWithCoder: (NSCoder*) aDecoder;

-(void) encodeWithCoder: (NSCoder*) anEncoder;
@end
