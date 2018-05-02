//
//  AACPlayer.h
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/20.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AACPlayer : NSObject

- (void)play;

- (double)getCurrentTime;

@end
