//
//  NEButtonWindowController.m
//  NESample
//
//  Created by Robin on 2021/7/24.
//

#import "NEButtonWindowController.h"
#import "NEButtonWindow.h"


@interface NEButtonWindowController ()

@property (nonatomic, strong) NEButtonWindow *buttonWindow;

@end

@implementation NEButtonWindowController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _buttonWindow = [[NEButtonWindow alloc] init];;
        self.window = _buttonWindow;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
@end
