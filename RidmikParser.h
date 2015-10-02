
#import "BanglaUnicode.h"


@interface RidmikParser : NSObject {

  BanglaUnicode* unicode;
    
}

- (id)init;
+ (RidmikParser *) getInstance;
- (NSString *)toBangla:(NSString *)engWord;
- (NSString*) getOther: (NSString*) ww;

- (BOOL)isVowel:(char)now;

- (BOOL)isConsonant:(char)now;

- (BOOL)isCharInString:(char)now
                  :(NSString *)foo;

- (BOOL)isStringInString:(NSString*)now
                    :(NSString *)foo;

- (BOOL)dualSitsUnder:(char)thirdCarry
                     :(char)secondCarry
                     :(char)carry
                     :(char)now;

- (BOOL)notJukta:(char)thirdCarry
                :(char)secondCarry
                :(char)carry
                :(char)now;

@end
