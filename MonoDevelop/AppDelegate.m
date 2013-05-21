//
//  AppDelegate.m
//  MonoDevelop
//
//  Created by gaolei on 12-12-26.
//  Copyright (c) 2012年 gaolei. All rights reserved.
//

#import "AppDelegate.h"
//#import <Carbon/Carbon.h>
static NSString* TextMateBundleIdentifier = @"com.happiplay.MonoDevelop";
@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    NSAppleEventDescriptor*  evt = [[NSAppleEventManager sharedAppleEventManager] currentAppleEvent];
	if( evt )
	{
		NSAppleEventDescriptor*  param = [evt paramDescriptorForKeyword: keyAEPosition];
		if( param )		// This is always false when xCode calls us???
		{
			NSData*					data = [param data];
            NSString* desc=[data description];
		}
	}
}
-(void)application:(NSApplication *)sender openFiles:(NSArray *)filenames{
  
    NSString* filename=[filenames objectAtIndex:0];
    if([filename rangeOfString:@".cs"].location!=NSNotFound||[filename rangeOfString:@".txt"].location!=NSNotFound||[filename rangeOfString:@".js"].location!=NSNotFound||[filename rangeOfString:@".rsp"].location!=NSNotFound){
        NSAppleEventDescriptor*  evt = [[NSAppleEventManager sharedAppleEventManager] currentAppleEvent];
        if( evt )
        {
            NSAppleEventDescriptor*  param = [evt paramDescriptorForKeyword: keyAEPosition];
            if( param )		// This is always false when xCode calls us???
            {
                NSData*					data = [param data];
                
                struct SelectionRange   range;
                
                memmove( &range, [data bytes], sizeof(range) );
                NSString* execstr=[NSString stringWithFormat:@"\"/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl\" \"%@:%d\"",filename,range.lineNum+1];
                NSLog(@"%@",execstr);
                system([execstr UTF8String]);
                exit(0);
            }
        }
    }
    
    
    
}
@end
