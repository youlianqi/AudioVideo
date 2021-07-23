//
//  main.m
//  NESample
//
//  Created by Robin on 2021/7/22.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    
        int retVal = 0;
#if DEBUG
        @try {
            NEApplication* applicaton = [NEApplication sharedApplication];
            id delegete = [[AppDelegate alloc] init];
            applicaton.delegate= delegete;
            
            retVal = NSApplicationMain(argc, argv);
        }
        @catch (NSException *exception) {
          NSLog(@"CRASH: %@", exception);
          NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
        }
        @finally {
          NSLog(@"finally");
        }
#else
        NEApplication* applicaton = [NEApplication sharedApplication];
        id delegete = [[AppDelegate alloc] init];
        applicaton.delegate= delegete;
        retVal = NSApplicationMain(argc, argv);
#endif
        return retVal;
    }
    return NSApplicationMain(argc, argv);
}
