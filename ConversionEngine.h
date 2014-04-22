
#import <Cocoa/Cocoa.h>
#import "RidmikParser.h"

/*!
    @class
    @abstract    Sample Conversion Engine
    @discussion  It is not necessary to have a separate object.  It is done here to demonstrate how it is possible to modularize your input method.
				 
				 This object uses an NSNumberFormatter to format input text.  The single formatter is shared between all input sessions.
				 The ConversionEngine also uses an NSCharacterSet that determines how the output number should be formatted.
*/

@interface ConversionEngine : NSObject {
    
}

/*
	@method
	@abstract		Convert the input text.
	@discussion		convert takes the input text buffer as input a returns a string that has been formatted to a given number format.
*/
-(NSString*)convert:(NSString*)string;

/*
	@method
	@abstract		Return the current conversion mode.
	@discussion		convert takes the input text buffer as input a returns a string that has been formatted to a given number format.
*/

@end
