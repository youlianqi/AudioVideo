//
//  AppDelegate.m
//  NESample
//
//  Created by Robin on 2021/7/22.
//

#import "AppDelegate.h"
#import "NEUIMgr.h"
#import "NEMainWindow.h"

@implementation NEApplication
@end

@interface AppDelegate ()<NSWindowDelegate>

@property (nonatomic, strong) NEMainWindow * mainWindow;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[NEUIMgr sharedInstance] showMainWindowWithDelegate:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
