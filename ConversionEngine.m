
#import "ConversionEngine.h"
#import "RidmikParser.h"


@implementation ConversionEngine

-(NSString*)convert:(NSString*)string
{
    RidmikParser*   parser = [[RidmikParser alloc] init];
	NSString *converted = [parser toBangla:string];
	return converted;
}

-(void)dealloc {
    [super dealloc];
}

@end
