//
//  VideoPacket.h
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoPacket : NSObject

@property uint8_t *buffer;
@property NSInteger size;

- (instancetype)initWithSize:(NSInteger)size;

@end
