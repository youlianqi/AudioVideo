//
//  NETextField.m
//  NESample
//
//  Created by Robin on 2021/7/23.
//

#import "NETextField.h"
#import "NETextFieldCell.h"

@implementation NETextField


- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizedTextField];
    }
    return self;
}
 
-(void) customizedTextField{
    self.cell = [[NETextFieldCell alloc] init];
    // 此处可以加入各种style设置
}
 
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
