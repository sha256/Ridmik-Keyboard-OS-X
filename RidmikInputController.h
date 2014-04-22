
#import <Cocoa/Cocoa.h>
#import <InputMethodKit/InputMethodKit.h>

@interface RidmikInputController : IMKInputController {
		
		//_composedBuffer contains text that the input method has converted
		NSMutableString*				_composedBuffer;
		//_original buffer contains the text has it was received from user input.
		NSMutableString*				_originalBuffer;
		//used to mark where text is being inserted in the _composedBuffer
		NSInteger						_insertionIndex;
		//This flag indicates that the original text was converted once in response to a trigger (space key)
		//the next time the trigger is received the composition will be committed.
		BOOL							_didConvert;
}

// These are simple methods for managing our composition and original buffers.
// They are all simple wrappers around basic NSString methods.
-(NSMutableString*)composedBuffer;
-(void)setComposedBuffer:(NSString*)string;

-(NSMutableString*)originalBuffer;
-(void)originalBufferAppend:(NSString*)string client:(id)sender;
-(void)setOriginalBuffer:(NSString*)string;

- (BOOL)convert:(NSString*)trigger key:(NSInteger)keyCode client:(id)sender;

@end
