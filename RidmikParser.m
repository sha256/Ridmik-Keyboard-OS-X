
#import "RidmikParser.h"
#import "BanglaUnicode.h"
#import <ctype.h>


@implementation RidmikParser

- (id)init
{
    
    self = [super init];
    if (self) {
        unicode = [[BanglaUnicode alloc] init];
    }
    
    return self;
}


-(NSString*) toBangla:(NSString *)engWord
{
 
    NSMutableString* st = [[NSMutableString alloc] init];
    char carry = 0;
    char secondCarry = 0;
    char thirdCarry = 0;
    BOOL tempNoCarry = false;
    BOOL jukta = false;
    BOOL prevJukta = false;
    BOOL prevDual = false;
    
    unichar charArray[[engWord length] + 1];
    [engWord getCharacters:charArray range:NSMakeRange(0, [engWord length])];

 
    for(int i=0; i < [engWord length]; i++){
        char now = charArray[i];

 
        if(!((now >= 'a' && now <= 'z') || (now >= 'A' && now <= 'Z') || (now >= '0' && now <= '9'))){
            [st appendString:[NSString stringWithFormat:@"%c",now]];
            carry = 0;
 
            continue;
        }
 
        if(now == 'A' || now == 'B' || now == 'C' || now == 'E' || now == 'F' || now == 'P' || now == 'X')
            now = tolower(now);
        if(now == 'K' || now == 'L' || now == 'M' || now == 'V' || now == 'Y' || now == 'W' || now == 'Q' )
            now = tolower(now);
        
        if(now == 'H' && carry != 'T') // khondiyo to -> TH
            now = 'h';
        
        // 'w' should be 'O' when it's the first one or comes after a vowel
        if((carry == 0 || [self isVowel:carry]) && now == 'w')
            now = 'O';
        
        
        if([self isVowel:now]){
            
            // special for wri kar & wri
            if(carry=='r' && secondCarry == 'r' && now =='i'){
                
                if(thirdCarry == 0){
                    [st deleteCharactersInRange:NSMakeRange([st length] - 2, 2)];
                    [st appendString:@"\u098B"];
                }else {
                    [st deleteCharactersInRange:NSMakeRange([st length] - 3, 3)];
                    [st appendString:@"\u09C3"];
                }
                carry = 'i';
                continue;
                
            }
 
            NSString* dual;
            
            if(secondCarry != 0)
                dual = [unicode getDualKar:now :carry];
            else
                dual = [unicode getDual:now :carry]; // dual as the first character of st
            
            if(dual != nil){
                if(carry != 'o')
                    [st deleteCharactersInRange:NSMakeRange([st length] - 1, 1)];
                if([self isVowel:secondCarry]){ // a dual kar does not applied on vowel
                    [st appendString:[unicode get:carry]];
                    [st appendString:[unicode get:now]];
                }else
                [st appendString:dual];
            }else if(now == 'o' && carry != 0){
                if([self isVowel:carry])
                    [st appendString:[unicode get: 'O']];
                else {
                    thirdCarry = secondCarry;
                    secondCarry = carry;
                    carry =  now; // carry = 0
                    continue;
                }
            }else if([self isVowel:carry] || carry == 0){
                if(now == 'a' && carry != 0) {// not first a
                    [st appendString:[unicode get: 'y']];
                    [st appendString:[unicode getKar:'a']];
                }
                else
                    [st appendString:[unicode get: now]];
            }else {
                [st appendString:[unicode getKar:now]];
            }
            
        }
        
        
        if(now == 'y' || now == 'Z' || now == 'r')
            jukta = false;
        
        // when previous was a jukta and dual of the later two is not available
        // go to the else part of the next if block i.e now is independent
        tempNoCarry = jukta && [unicode getDual:now :carry] == nil;
        
        if([self isConsonant:now] && [self isConsonant:carry] && !tempNoCarry){
            
            // handle jo fola
            
            if(now == 'y' || now == 'Z'){
                if(now == 'y' && carry == 'q' && secondCarry == 'q');
                else
                    now = 'z';
            }
            
            
            
            // handle kkh = kSh
            if(secondCarry == 'k' && carry == 'k' && now == 'h')
                carry = 'S';
            
            // check if dual
            NSString* dual = [unicode getDual:now :carry];
            
            
            if(dual != nil && !prevDual){
                
                prevDual = true;
                // handle kaNgkShito
                if(thirdCarry == 'g' && secondCarry == 'k' && carry == 'S' && now == 'h')
                    prevJukta = jukta = false;
                
                BOOL firstOrAfterVowelOrJukta = [self isVowel:secondCarry] || secondCarry == 0 || prevJukta;
                
                if([self dualSitsUnder:thirdCarry :secondCarry :carry :now] && !firstOrAfterVowelOrJukta){
                    [st deleteCharactersInRange:NSMakeRange([st length] - 1, 1)];
                    if(secondCarry == 'r' && thirdCarry == 'r')
                        [st deleteCharactersInRange:NSMakeRange([st length] - 1, 1)];
                    if(jukta);
                    else if(secondCarry != 0 && ![self isVowel:secondCarry])
                        [st appendString:@"\u09CD"];
                    
                    [st appendString:dual];
                    prevJukta = jukta;
                    // Jukta should be false in case we want to have three jukta letters
                    jukta = true;
                    
                }else {
                    if(jukta)
                        [st deleteCharactersInRange:NSMakeRange([st length] - 2, 2)];
                    else [st deleteCharactersInRange:NSMakeRange([st length] - 1, 1)];
                    [st appendString:dual];
                    prevJukta = jukta;
                    jukta = false;
                }
                
                
            }else {
                prevDual = false;
                prevJukta = jukta;
                jukta = false;
                
                if(secondCarry != 'r' && carry == 'r' && now == 'z'){
                    [st appendString:@"\u200D\u09CD"]; // handle rya as in ransom/rapid
                }
                else if(carry == 'r' && secondCarry != 'r');
                // no ref when (c) rr (c)
                else if(carry == 'r' && secondCarry == 'r' && [self isConsonant:thirdCarry]);
                // ref when (v) rr (c)
                else if(carry == 'r' && secondCarry == 'r' && ([self isVowel:thirdCarry] || thirdCarry == 0)){
                    [st deleteCharactersInRange:NSMakeRange([st length] - 1, 1)];
                    [st appendString:@"\u09CD"]; // jukta added for ref, but jukta not true
                }
                
                else if([self notJukta:thirdCarry :secondCarry :carry :now]);
                else {
                    [st appendString:@"\u09CD"];
                    //prevJukta = jukta;
                    jukta = true;
                }
                
                [st appendString:[unicode get:now]];
                
            }
            
        } else if([self isConsonant:now]){
            prevDual = false;
            if([self isVowel:carry] && now == 'Z')
                [st appendString:@"\u09CD"];
            
            if(carry == 0 && now == 'x')
                [st appendString:[unicode get:'e']];
            
            prevJukta = jukta;
            jukta = false;
            
            // to write b-fola
            if(now == 'w' && [self isConsonant: carry] && [self isConsonant:secondCarry]){
                [st appendString:@"\u09CD"];
                prevJukta = jukta;
                jukta = true;
            }
            // handle lakshmi/ lokhnou
            if(thirdCarry == 'k' && secondCarry == 'S' && carry == 'h' && (now == 'N' || now == 'm')){
                [st appendString:@"\u09CD"];
                prevJukta = false;
                jukta = true;
            }
            [st appendString:[unicode get:now]];
                                                           
                                                           
            
        }
        
        thirdCarry = secondCarry;
        secondCarry = carry;
        carry = now;
    } // end of for loop
    
    return [st description];
}

-(BOOL) isVowel: (char) now
{
    if([@"AEIOUaeiou" rangeOfString:[NSString stringWithFormat:@"%c", now]].location == NSNotFound)
        return false;
    return true;
}

-(BOOL) isConsonant: (char) now
{
    return ![self isVowel:now] && isalpha(now);
}


-(BOOL) isCharInString: (char) now :(NSString*) foo
{
    if([foo rangeOfString:[NSString stringWithFormat:@"%c", now]].location == NSNotFound)
        return false;
    return true;
}

-(BOOL) isStringInString: (NSString*) string :(NSString*) foo
{
    if([foo rangeOfString:string].location == NSNotFound)
        return false;
    return true;
}

-(BOOL) dualSitsUnder: (char) thirdCarry :(char) secondCarry :(char) carry :(char) now
{
    
    if(secondCarry == 'r' && thirdCarry == 'r')
        return true;
    
    if(secondCarry == 'r')
        return false;
    
    NSString* djkt = [unicode getDjkt: carry :now];
    
    if(djkt != nil)
        if([self isCharInString: secondCarry :djkt])
            return true;
    
    NSString* djktt = [unicode getDjktt: carry :now];
    
    if(djktt != nil)
        return [self isStringInString:[NSString stringWithFormat:@"%c%c", thirdCarry, secondCarry] : djktt];
    
    // if we didn't cover it here, let's assume it sits under a consonant so we return true
    // but making it false has some advantages, e.g. the blocks that has only two lines
    // can be removed.. So when we're finished this function should return false
    return false;
}

-(BOOL) notJukta: (char) thirdCarry :(char) secondCarry :(char) carry :(char) now
{
    
    if(secondCarry == 'n' && carry == 'g' && now == 'r')
        return true;
    
    if(now == 'r' || now == 'z' || now == 'w')
        return false;
	
    NSString* foo = [unicode getDualJkt:secondCarry :carry];
    
    if(foo != nil)
        return ![self isCharInString:now :foo]; //? false : true;
    
    foo = [unicode getJkt:carry];
    if(foo != nil)
        return ![self isCharInString: now :foo]; // ? false : true;

    
    // if we didn't cover it here let's assume a consonant sits under it so we return false
    // but making it true has some advantages, e.g. the blocks that has only two lines
    // can be removed.. So when we're finished, this function should return true
    return true;
}

- (void)dealloc
{
    [unicode release];
    [super dealloc];
}


@end
