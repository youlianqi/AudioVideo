//
//  NETextFieldCell.m
//  NESample
//
//  Created by Robin on 2021/7/23.
//

#import "NETextFieldCell.h"

@implementation NETextFieldCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [NSFont systemFontOfSize:13.0f];
        self.textColor = [NSColor controlTextColor];
        self.backgroundColor = [NSColor clearColor];
        self.bezeled = NO;
        self.drawsBackground = NO;
        self.bordered = NO;
    }
    return self;
}

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame {
   // super would normally draw text at the top of the cell
   CGFloat fontSize = self.font.boundingRectForFont.size.height;
   NSInteger offset = floor((NSHeight(frame) - ceilf(fontSize))/2);
   NSRect centeredRect = NSInsetRect(frame, 2, offset);
   return centeredRect;
}

- (NSRect)drawingRectForBounds:(NSRect)rect{
   NSRect newRect = [super drawingRectForBounds:rect];
   NSSize textSize = [self cellSizeForBounds:rect];
   CGFloat heightDelta = newRect.size.height - textSize.height;
   if (heightDelta > 0) {
       newRect.size.height = textSize.height;
       newRect.origin.y += heightDelta * 0.5;
   }
   return newRect;
}

- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView
              editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event {
   [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect]
                 inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView
                editor:(NSText *)editor delegate:(id)delegate
                 start:(NSInteger)start length:(NSInteger)length {
   
   [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect]
                   inView:controlView editor:editor delegate:delegate
                    start:start length:length];
}

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view {
   [super drawInteriorWithFrame:
   [self adjustedFrameToVerticallyCenterText:frame] inView:view];
}

@end
