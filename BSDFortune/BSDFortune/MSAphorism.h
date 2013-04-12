//
//  MSAphorism.h
//  BSDFortune
//
//  Created by Michael Shafae on 4/9/13.
//  Copyright (c) 2013 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSAphorism : NSObject

@property (retain, nonatomic) NSString* text;
@property (readonly, nonatomic) NSString* HTMLtext;
@property (assign, nonatomic) unsigned int ident;

-(MSAphorism*) initWithID: (unsigned int) anIdent AndText: (NSString*) anAphorism;
@end
