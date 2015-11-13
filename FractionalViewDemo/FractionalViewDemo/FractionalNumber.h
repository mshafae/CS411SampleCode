//
//  FractionalNumber.h
//  FractionalNumber
//
//  Created by Michael Shafae on 10/1/14.
//  Copyright (c) 2014 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FractionalNumber : NSObject
@property (assign, readonly, nonatomic) int numerator;
@property (assign, readonly, nonatomic) int denominator;

-(FractionalNumber*) initWithNumerator: (int) aNumerator denominator: (int) aDenominator;

-(NSString*) stringValue;

@end
