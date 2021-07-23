//
//  NEMainWindowController.m
//  NESample
//
//  Created by Robin on 2021/7/23.
//

#import "NEMainWindowController.h"
#import "NEUIMgrProtocol.h"

@interface NEMainWindowController ()<NEUIMgrDelegate>

@property (nonatomic, strong) NEMainWindow *mainWindow;

@end

@implementation NEMainWindowController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainWindow = [[NEMainWindow alloc] init];;
        self.window = _mainWindow;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
