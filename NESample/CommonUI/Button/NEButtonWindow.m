//
//  NEButtonWindow.m
//  NESample
//
//  Created by Robin on 2021/7/23.
//

#import "NEButtonWindow.h"
#import "NEButtonWindowContentView.h"

@interface NEButtonWindow()

@property (nonatomic, strong) NEButtonWindowContentView *buttonWindowContentView;

@end

@implementation NEButtonWindow

- (instancetype)init
{
    NSWindowStyleMask style = NSWindowStyleMaskBorderless | NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    NSRect contentRect = NSMakeRect(0, 0, 800, 540);
    
    self = [super initWithContentRect:contentRect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        [self setHasShadow:YES];
        [self setRestorable:YES];
        self.depthLimit = NSWindowDepthTwentyfourBitRGB;
        self.colorSpace = [NSColorSpace genericRGBColorSpace];
        [self setMinSize:CGSizeMake(480, 270)];
        
        [self customizeTitle];
        self.contentView = self.buttonWindowContentView;
    }
    return self;
}

- (NEButtonWindowContentView *)buttonWindowContentView {
    if (!_buttonWindowContentView) {
        _buttonWindowContentView = [[NEButtonWindowContentView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }

    return _buttonWindowContentView;
}

- (void)customizeTitle
{
    self.title = NSLocalizedString(@"Button", nil);
}

@end
