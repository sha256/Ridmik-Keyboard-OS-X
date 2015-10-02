//
//  BanglaUnicode.h
//  RidmikOSX
//
//  Created by Shamim Hasnath on 4/21/14.
//  Copyright (c) 2014 Ridmik Lab. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BanglaUnicode : NSObject {
    
    NSDictionary*  map;
    NSDictionary* kars;
    NSDictionary* jkt;
    NSDictionary* djkt;
    NSDictionary* djktt;
    NSDictionary* other;
    
}

- (id)init;
-(NSString*) get: (char) c;
-(NSString*) getDual: (char) c :(char) carry;
-(NSString*) getKar: (char)c;
-(NSString*) getDualKar:(char)c :(char)carry;
-(NSString*) getJkt:(char)c;
-(NSString*) getDualJkt:(char)secondCarry :(char)carry;
-(NSString*) getDjkt:(char)secondCarry :(char)carry;
-(NSString*) getDjktt:(char)secondCarry :(char)carry;
-(NSString*) getOther: (NSString*) w;

@end
