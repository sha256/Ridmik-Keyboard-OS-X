#import "RidmikInputController.h"
#import "ConversionEngine.h"
#import "ApplicationDelegate.h"



@implementation RidmikInputController


-(BOOL) inputText:(NSString *)string key:(NSInteger)keyCode modifiers:(NSUInteger)flags client:(id)sender
{
    // Return YES to indicate the the key input was received and dealt with.  Key processing will not continue in that case.
    // In other words the system will not deliver a key down event to the application.
    // Returning NO means the original key down will be passed on to the client.
    
    
    if (flags & NSCommandKeyMask){
        return NO;
    }

    
    BOOL					inputHandled = NO;

  // NSLog(@"Input:%@ key:%ld modifiers:%lx", string, keyCode, flags);
    
    
    NSRange range = [string rangeOfString:@"^[a-zA-Z]+$" options: NSRegularExpressionSearch];
    if(range.location != NSNotFound){
        [self originalBufferAppend:string client:sender];
        inputHandled = YES;
        return YES;
    } 

      NSRange r2 = [string rangeOfString:@"^[0-9|:]$" options: NSRegularExpressionSearch];
    
    if (r2.location !=  NSNotFound){
        [self commitComposition: sender];
        [self setComposedBuffer: [[[NSApp delegate] conversionEngine] convertOther:string]];
        [self commitComposition: sender];
        return YES;        
    }

        // If the input isn't part of a decimal number see if we need to convert the previously input text.
    inputHandled = [self convert:string key:keyCode client:sender];
    
    //NSLog(@"Before inputtext finish");
   
    return inputHandled;
}

/*!
    @method     
    @abstract   Called when a user action was taken that ends an input session.   Typically triggered by the user selecting a new input method or keyboard layout.
    @discussion When this method is called your controller should send the current input buffer to the client via a call to insertText:replacementRange:.  Additionally, this is the time to clean up if that is necessary.
*/

-(void)commitComposition:(id)sender 
{
	NSString*		text = [self composedBuffer];

	if ( text == nil || [text length] == 0 ) {
		text = [self originalBuffer];
       // NSLog(@"composed buffer empty");
	}
	
	[sender insertText:text replacementRange:NSMakeRange(NSNotFound, NSNotFound)];
	
	[self setComposedBuffer:@""];
	[self setOriginalBuffer:@""];
	_insertionIndex = 0;
	_didConvert = NO;
}

// Return the composed buffer.  If it is NIL create it.  
-(NSMutableString*)composedBuffer;
{
	if ( _composedBuffer == nil ) {
		_composedBuffer = [[NSMutableString alloc] init];
	}
	return _composedBuffer;
}

// Change the composed buffer.
-(void)setComposedBuffer:(NSString*)string
{
	NSMutableString*		buffer = [self composedBuffer];
	[buffer setString:string];
}


// Get the original buffer.
-(NSMutableString*)originalBuffer
{
	if ( _originalBuffer == nil ) {
		_originalBuffer = [[NSMutableString alloc] init];
	}
	return _originalBuffer;
}

// Add newly input text to the original buffer.
-(void)originalBufferAppend:(NSString*)string client:(id)sender
{
	NSMutableString*		buffer = [self originalBuffer];
	[buffer appendString: string];
    
    //NSLog(@"Final Buffer: %@", buffer);
    
    NSString* news = [[[NSApp delegate] conversionEngine] convert:buffer];
    [self setComposedBuffer:news];
    
	_insertionIndex++;
    
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInt:0], NSMarkedClauseSegmentAttributeName,
                              [NSNumber numberWithInt:NSUnderlineStyleNone], NSUnderlineStyleAttributeName,
                              nil];
    
    NSMutableAttributedString *attrString = [[[NSMutableAttributedString alloc] initWithString:news attributes:attrDict] autorelease];
        
    [sender setMarkedText:attrString selectionRange:NSMakeRange(0, [news length]) replacementRange:NSMakeRange(NSNotFound, NSNotFound)];

}

// Change the original buffer.
-(void)setOriginalBuffer:(NSString*)string
{
	NSMutableString*		buffer = [self originalBuffer];
	[buffer setString:string];
}

- (void)deleteBackward:(id)sender
{
	NSMutableString*		originalText = [self originalBuffer];
	NSString*				convertedString;

	if ( _insertionIndex > 0 && _insertionIndex <= [originalText length] ) {
		--_insertionIndex;
		[originalText deleteCharactersInRange:NSMakeRange(_insertionIndex,1)];
		convertedString = [[[NSApp delegate] conversionEngine] convert:originalText];
		[self setComposedBuffer:convertedString];
		[sender setMarkedText:convertedString selectionRange:NSMakeRange(_insertionIndex, 0) replacementRange:NSMakeRange(NSNotFound,NSNotFound)];

    }
}


- (BOOL)convert:(NSString*)trigger key:(NSInteger)keyCode client:(id)sender
{
	NSString*				originalText = [self originalBuffer];
	NSString*				convertedString = [self composedBuffer];
	BOOL					handled = NO;
    
    if(keyCode == 51 && [originalText length] > 0){
        [self deleteBackward:sender];
        return YES;
    }

    
    convertedString = [[[NSApp delegate] conversionEngine] convert:originalText];
    [self setComposedBuffer:convertedString];
    [self commitComposition:sender];
    handled = NO;

	return handled;
}

-(void)setValue:(id)value forTag:(long)tag client:(id)sender
{
	//NSLog(@"setvalll llllllll");
}

- (NSUInteger)recognizedEvents:(id)sender
{
    
    return NSKeyDownMask | NSFlagsChangedMask | NSLeftMouseDownMask | NSRightMouseDownMask | NSLeftMouseDraggedMask |    NSRightMouseDraggedMask;
}



- (BOOL)mouseDownOnCharacterIndex:(NSUInteger)index coordinate:(NSPoint)point withModifier:(NSUInteger)flags continueTracking:(BOOL *)keepTracking client:(id)sender
{
    
    return NO;
}



-(void)dealloc 
{
	[_composedBuffer release];
	[_originalBuffer release];
	[super dealloc];
}

 
@end

