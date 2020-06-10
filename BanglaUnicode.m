//
//  BanglaUnicode.m
//  RidmikOSX
//
//  Created by Shamim Hasnath on 4/21/14.
//  Copyright (c) 2014 Ridmik Lab. All rights reserved.
//

#import "BanglaUnicode.h"

@implementation BanglaUnicode

- (id) init {
    self = [super init];
    if (self) {
        
        map = @{
                @"o" : @"\u0985", // shore o
                @"O" : @"\u0993", // rossho o
                @"a" : @"\u0986", // aa
                @"A" : @"\u0986", // aa
                @"S" : @"\u09B6", // talobbo sho
                @"sh" : @"\u09B6", // talobbo sho
                @"s" : @"\u09B8",  // donto sho
                @"Sh" : @"\u09B7", // murdonno sho
                @"h" : @"\u09B9", // ho
                @"H" : @"\u09B9", // ho
                @"r" : @"\u09B0", // ro
                @"R" : @"\u09DC", // dhoye shunne ro
                @"Rh" : @"\u09DD", // dhoye shunne ro
                @"k" : @"\u0995", // ko
                @"K" : @"\u0995", // ko
                @"q" : @"\u0995",
                @"qq" : @"\u0981", // chondro bindu
                @"kh" : @"\u0996", // kho
                @"g" : @"\u0997", // go
                @"G" : @"\u0997", //go
                @"gh" : @"\u0998", // gho
                @"Ng" : @"\u0999", // unga
                @"c" : @"\u099A", // cho
                @"C" : @"\u099A", // cho
                @"ch" : @"\u099B", // ccho
                @"j" : @"\u099C", // jo
                @"jh" : @"\u099D", // jho
                @"J" : @"\u099C", // jho
                @"NG" : @"\u099E", // niyo
                @"T" : @"\u099F", // To
                @"Th" : @"\u09A0", // Tho
                @"TH" : @"\u09CE", // khondiyo to
                @"f" : @"\u09AB", // fo
                @"F" : @"\u09AB", // fo
                @"ph" : @"\u09AB", // fo
                @"i" : @"\u0987", // rossho i
                @"I" : @"\u0988", // dhirgo i
                @"e" : @"\u098F", // e
                @"E" : @"\u098F", // e
                @"u" : @"\u0989", // rossho u
                @"U" : @"\u098A", // dhirgo u
                @"b" : @"\u09AC", // bo
                @"B" : @"\u09AC", // bo
                @"w" : @"\u09AC", // bo
                @"bh" : @"\u09AD", // bho
                @"V" : @"\u09AD", // bho
                @"v" : @"\u09AD", // bho
                @"t" : @"\u09A4", // to
                @"th" : @"\u09A5", // tho
                @"d" : @"\u09A6", // do
                @"dh" : @"\u09A7", // dho
                @"D" : @"\u09A1", // do
                @"Dh" : @"\u09A2", // dho
                @"n" : @"\u09A8", // donto no
                @"N" : @"\u09A3", // murdo no
                @"z" : @"\u09AF", // zho
                @"Z" : @"\u09AF", // zho fola
                @"y" : @"\u09DF", // ontosto yo
                @"l" : @"\u09B2", // lo
                @"L" : @"\u09B2", // lo
                @"m" : @"\u09AE", // mo
                @"M" : @"\u09AE", // mo
                @"P" : @"\u09AA", // po
                @"p" : @"\u09AA", // po
                @"ng" : @"\u0982", // onushar
                @"cb" : @"\u0981", // chondro point
                @"x" : @"\u0995\u09CD\u09B8",
                @"OU" : @"\u0994",
                @"OI" : @"\u0990",
                @"hs" : @"\u09CD",
                @"nj" : @"\u099E\u09CD\u099C", //
                @"nc" : @"\u099E\u09CD\u099A", //
                @"gg" : @"\u099C\u09CD\u099E"
                };
        
        kars = @{
                 @"o" : @"",  // o kar
                 @"a" : @"\u09BE",  // aa kar
                 @"A" : @"\u09BE",  // aa kar
                 @"e" : @"\u09C7",  // e kar
                 @"E" : @"\u09C7",  // e kar
                 @"O" : @"\u09CB",  // O kar
                 @"OI" : @"\u09C8",  // OI kar
                 @"OU" : @"\u09CC",
                 @"i" : @"\u09BF",  // rossho i kar
                 @"I" : @"\u09C0",  //dhirgo i karu
                 @"u" : @"\u09C1",  // rossho u kar
                 @"U" : @"\u09C2",  // dhirgo u kar
                 @"oo" : @"\u09C1",  // rossho u kar
                 };
        
        jkt = @{
                @"k" : @"kTtnNslw",
                @"g" : @"gnNmlw",
                @"ch" : @"w",
                @"Ng" : @"gkm",
                @"NG" : @"cj",
                @"g" : @"gnNmlw",
                @"G" : @"gnNmlw",
                @"th" : @"w",
                @"gh" : @"Nn",
                @"c" : @"c",
                @"j" : @"jw",
                @"T" : @"T",
                @"D" : @"D",
                @"R" : @"g",
                @"N" : @"DNmwT",
                @"t" : @"tnmwN",
                @"d" : @"wdmv",
                @"dh" : @"wn",
                @"n" : @"ndwmtsDT",
                @"p" : @"plTtns",
                @"f" : @"l",
                @"ph" : @"l",
                @"b" : @"jdbwl",
                @"v" : @"l", 
                @"bh" : @"l", 
                @"m" : @"npfwvmlb", 
                @"l" : @"lwmpkgTDf", 
                @"Sh" : @"kTNpmf", 
                @"S" : @"clwnm", 
                @"sh" : @"clwnm", 
                @"s" : @"kTtnpfmlw", 
                @"h" : @"Nnmlw", 
                @"cb" : @"", 
                @"jh" : @"", 
                @"TH" : @"", 
                @"qq" : @"", 
                @"ng" : @"", 
                @"kh" : @"", 
                @"gg" : @"", 
                @"dh" : @"", 
                @"Th" : @"",
                };
        
        djkt = @{
                 @"kh" : @"Ngs",
                 @"ch" : @"c",
                 @"Dh" : @"N",
                 @"ph" : @"mls",
                 @"dh" : @"gdnbl",
                 @"bh" : @"dm",
                 @"Sh" : @"k",
                 @"th" : @"tns", 
                 @"Th" : @"Nn", 
                 @"jh" : @"j", 
                 @"NG" : @"cj"
                 };
        
        djktt = @{
                  @"ch" : @"NG",
                  @"gh" : @"Ng",
                  @"Th" : @"Sh",
                  @"jh" : @"NG",
                  @"sh" : @"ch", 
                  };
        
        other = @{
                  @"0"  : @"\u09E6",
                  @"1"  : @"\u09E7",
                  @"2"  : @"\u09E8",
                  @"3"  : @"\u09E9",
                  @"4"  : @"\u09EA",
                  @"5"  : @"\u09EB",
                  @"6"  : @"\u09EC",
                  @"7"  : @"\u09ED",
                  @"8"  : @"\u09EE",
                  @"9"  : @"\u09EF",
                  @"|"  : @"\u0964",
                  @":"  : @"\u0983",
                  };
    }
    return self;
}

- (NSString*) getOther: (NSString*) w {
    return  [other objectForKey: w];
}

-(NSString*) get:(char)c {
    return [map objectForKey:[NSString stringWithFormat:@"%c", c]];
}

-(NSString*) getDual:(char)c :(char)carry {
    if (carry == 0) return nil;
    return [map objectForKey: [NSString stringWithFormat:@"%c%c", carry, c]];
}

-(NSString*) getKar: (char)c {
    return [kars objectForKey:[NSString stringWithFormat:@"%c", c]];
}

-(NSString*) getDualKar:(char)c :(char)carry {
    if (carry == 0) return nil;
    return [kars objectForKey: [NSString stringWithFormat:@"%c%c", carry, c]];
}

-(NSString*) getJkt:(char)c {
    return [jkt objectForKey:[NSString stringWithFormat:@"%c", c]];
}

-(NSString*) getDualJkt:(char)secondCarry :(char)carry {
    if (secondCarry == 0) return nil;
    return [jkt objectForKey: [NSString stringWithFormat:@"%c%c", secondCarry, carry]];
}

-(NSString*) getDjkt:(char)secondCarry :(char)carry {
    if (secondCarry == 0) return nil;
    return [djkt objectForKey: [NSString stringWithFormat:@"%c%c", secondCarry, carry]];
}

-(NSString*) getDjktt:(char)secondCarry :(char)carry {
    if (secondCarry == 0) return nil;
    return [djktt objectForKey: [NSString stringWithFormat:@"%c%c", secondCarry, carry]];
}


- (void)dealloc {
    [map release];
    [kars release];
    [jkt release];
    [djkt release];
    [djktt release];
    [super dealloc];
}

@end
