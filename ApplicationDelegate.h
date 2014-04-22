
#import <Cocoa/Cocoa.h>
#import "ConversionEngine.h"

// The conversion engine is shared by all the input controllers. For that reason we store it in the application delegate where it 
// can be accessed by any of the controllers.
// Note that the ConversionEngine is instantiated automatically because we said to instantiate the engine object in Interface Builder.

@interface ApplicationDelegate : NSObject {
	IBOutlet ConversionEngine*			_conversionEngine;
}

-(ConversionEngine*)conversionEngine;

@end
