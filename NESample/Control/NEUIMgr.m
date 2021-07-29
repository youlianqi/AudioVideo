//
//  NEUIMgr.m
//  NESample
//
//  Created by Robin on 2021/7/22.
//

#import "NEUIMgr.h"
#import "NEMeetingUIMgr.h"
#import "NEMainWindowController.h"
#import "NEMainWindow.h"
#import "NEButtonWindow.h"
#import "NEButtonWindowController.h"

const CGFloat kMainWindowMinWidth             = 500;
const CGFloat kMainWindowMinHeight             = 440;    // this is the minimum height

@interface NEUIMgr()

@property (nonatomic, strong) NEMeetingUIMgr *meetingUIMgr;

@property (nonatomic, strong) NEMainWindowController *mainWindowController;
@property (nonatomic, strong) NEMainWindow *mainWindow;

@property (nonatomic, strong) NEButtonWindowController *buttonWindowController;
@property (nonatomic, strong) NEButtonWindow *buttonWindow;

@property (nonatomic, assign) NSModalSession mainWindowSession;
@property (nonatomic, assign) NSModalSession buttonWindowSession;

@end

@implementation NEUIMgr

+ (NEUIMgr *)sharedInstance {
    static NEUIMgr *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NEUIMgr alloc] init];
    });
    return instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(onNotifyWindowWillClose:) name:NSWindowWillCloseNotification object:nil];
    }
    return self;
}

#pragma mark - public

- (void)showMainWindowWithDelegate:(id)delegate
{
    [self showMainWindow];
    self.mainWindow.delegate = delegate;
}

- (void)showButtonWindow
{
    [self.mainWindow close];
    
    [self.buttonWindow center];
    [self.buttonWindow makeKeyAndOrderFront:self];
    self.buttonWindowSession = [NSApp beginModalSessionForWindow:self.buttonWindow];
}

#pragma mark -

- (NEMeetingUIMgr *)meetingUIMgr {
    if (!_meetingUIMgr) {
        _meetingUIMgr = [[NEMeetingUIMgr alloc] init];
    }
    
    return _meetingUIMgr;
}

#pragma mark - creates

- (NEMainWindowController *)mainWindowController
{
    if (!_mainWindowController) {
        _mainWindowController = [[NEMainWindowController alloc] init];
    }
    
    return _mainWindowController;
}

- (NEMainWindow *)mainWindow
{
    if (!_mainWindow) {
        _mainWindow = (NEMainWindow *)self.mainWindowController.window;
    }
    
    return _mainWindow;
}

- (NEButtonWindowController *)buttonWindowController
{
    if (!_buttonWindowController) {
        _buttonWindowController = [[NEButtonWindowController alloc] init];
    }
    
    return _buttonWindowController;
}

- (NEButtonWindow *)buttonWindow
{
    if (!_buttonWindow) {
        _buttonWindow = (NEButtonWindow *)self.buttonWindowController.window;
    }
    
    return _buttonWindow;
}

- (void)showMainWindow
{
    [self resizeMainWindow];
    [self.mainWindow center];
    [self.mainWindow makeKeyAndOrderFront:self];
    self.mainWindowSession = [NSApp beginModalSessionForWindow:self.mainWindow];
}

- (void)resizeMainWindow
{
    NSRect frameRect = [self.mainWindow frame];
    NSRect adjustRect = frameRect;
    if (adjustRect.size.width < kMainWindowMinWidth)
        adjustRect.size.width = kMainWindowMinWidth;

    if (adjustRect.size.height < kMainWindowMinHeight)
        adjustRect.size.height = kMainWindowMinHeight;
    
    [self.mainWindow setFrame:adjustRect display:YES];
}

- (void)onNotifyWindowWillClose:(NSNotification *)notification
{
    NSWindow *window = (NSWindow *)notification.object;
    if (_buttonWindow && _buttonWindow == window) {
        [self showMainWindow];
    }
}


@end
