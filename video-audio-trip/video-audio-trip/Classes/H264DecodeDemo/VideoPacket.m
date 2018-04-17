//
//  VideoPacket.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "VideoPacket.h"

@implementation VideoPacket

- (instancetype)initWithSize:(NSInteger)size{
    if (self = [super init]) {
        self.buffer = malloc(size);
        self.size = size;
    }
    return self;
}

-(void)dealloc{
    free(self.buffer);
}

@end
