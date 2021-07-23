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

const CGFloat kMainWindowMinWidth             = 700;
const CGFloat kMainWindowMinHeight             = 440;    // this is the minimum height

@interface NEUIMgr()

@property (nonatomic, strong) NEMeetingUIMgr *meetingUIMgr;
@property (nonatomic, strong) NEMainWindowController *mainWindowController;
@property (nonatomic, strong) NEMainWindow *mainWindow;

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
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - public

- (void)showMainWindowWithDelegate:(id)delegate
{
    [self createMainWindow];
    [self showMainWindow];
    _mainWindow.delegate = delegate;
}

#pragma mark -

- (NEMeetingUIMgr *)meetingUIMgr {
    if (!_meetingUIMgr) {
        _meetingUIMgr = [[NEMeetingUIMgr alloc] init];
    }
    
    return _meetingUIMgr;
}

#pragma mark - creates

- (void)createMainWindow
{
    _mainWindowController = [[NEMainWindowController alloc] init];
    _mainWindow = (NEMainWindow *)_mainWindowController.window;
}

- (void)showMainWindow
{
    [self resizeMainWindow];
    [_mainWindow center];
    [_mainWindow makeKeyAndOrderFront:self];
    [NSApp beginModalSessionForWindow:self.mainWindow];
}

- (void)resizeMainWindow
{
    NSRect frameRect = [_mainWindow frame];
    NSRect adjustRect = frameRect;
    if (adjustRect.size.width < kMainWindowMinWidth)
        adjustRect.size.width = kMainWindowMinWidth;

    if (adjustRect.size.height < kMainWindowMinHeight)
        adjustRect.size.height = kMainWindowMinHeight;
    
    [_mainWindow setFrame:adjustRect display:YES];
}


@end
