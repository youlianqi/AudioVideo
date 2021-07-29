//
//  NEMainWindow.m
//  NESample
//
//  Created by Robin on 2021/7/22.
//

#import "NEMainWindow.h"
#import "NEMainWindowController.h"
#import "NEMainWindowContentView.h"

@interface NEMainWindow()

@property (nonatomic, strong) NEMainWindowContentView *mainWindowContentView;

@end

@implementation NEMainWindow

- (instancetype)init
{
    NSWindowStyleMask style = NSWindowStyleMaskBorderless | NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    NSRect contentRect = NSMakeRect(0, 0, 500, 440);
    
    self = [super initWithContentRect:contentRect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        [self setHasShadow:YES];
        [self setRestorable:YES];
        self.depthLimit = NSWindowDepthTwentyfourBitRGB;
        self.colorSpace = [NSColorSpace genericRGBColorSpace];
        [self setMinSize:CGSizeMake(480, 270)];
        
        [self customizeTitle];
        self.contentView = self.mainWindowContentView;
    }
    return self;
}

- (NEMainWindowContentView *)mainWindowContentView {
    if (!_mainWindowContentView) {
        _mainWindowContentView = [[NEMainWindowContentView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    
    return _mainWindowContentView;
}

- (void)customizeTitle
{
    self.title = NSLocalizedString(@"网易云信 | 实时音视频", nil);
}


@end
