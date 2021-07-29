//
//  NEButtonWindowContentView.m
//  NESample
//
//  Created by Robin on 2021/7/24.
//

#import "NEButtonWindowContentView.h"

@interface NEButtonWindowContentView ()

@property (nonatomic, strong) NSButton *button;
@property (nonatomic, strong) NSButton *texturedRoundedbutton;

@end

@implementation NEButtonWindowContentView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)setupUI
{
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor windowBackgroundColor].CGColor;
    
    [self addSubview:self.button];
    [self addSubview:self.texturedRoundedbutton];
}

- (NSButton *)button {
    if (!_button) {
        _button = [[NSButton alloc] initWithFrame:CGRectZero];
        [_button setButtonType:NSButtonTypePushOnPushOff];
        _button.bezelStyle = NSBezelStyleRounded;
        _button.title = @"CodeButton";
        _button.target = self;
        _button.action = @selector(onButton:);
        _button.toolTip = @"Click here to open code button";
        _button.layer.backgroundColor = [NSColor blueColor].CGColor;
        _button.wantsLayer = YES;
    }
    
    return _button;
}

- (NSButton *)texturedRoundedbutton {
    if (!_texturedRoundedbutton) {
        _texturedRoundedbutton = [[NSButton alloc] initWithFrame:CGRectZero];
        [_texturedRoundedbutton setButtonType:NSButtonTypeRadio];
        _texturedRoundedbutton.bezelStyle = NSBezelStyleRounded;
        _texturedRoundedbutton.title = @"Textured Rounded";
        _texturedRoundedbutton.target = self;
        _texturedRoundedbutton.action = @selector(onTexturedRoundedButton:);
        _texturedRoundedbutton.toolTip = @"Click here to check Textured";
    }
    
    return _texturedRoundedbutton;
}



- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)layout
{
    [super layout];
    
    [self.button sizeToFit];
    CGRect buttonFrame = self.button.frame;
    buttonFrame.origin = CGPointMake(100, 100);
    self.button.frame = CGRectMake(100, 100, 400, 100);

    [self.texturedRoundedbutton sizeToFit];
    buttonFrame = self.texturedRoundedbutton.frame;
    buttonFrame.origin = CGPointMake(100, 200);
    self.texturedRoundedbutton.frame = buttonFrame;
}

- (void)onButton:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)onTexturedRoundedButton:(id)sender
{
    NSLog(@"%s",__FUNCTION__);
}


@end
