//
//  NEUIMgr.h
//  NESample
//
//  Created by Robin on 2021/7/22.
//

#import <Cocoa/Cocoa.h>
#import "NEUIMgrProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NEUIMgr : NSObject<NEUIMgrDelegate>

+ (NEUIMgr *)sharedInstance;

- (void)showMainWindowWithDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
