//
//  VideoFileParser.h
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPacket.h"

@interface VideoFileParser : NSObject

-(VideoPacket *)nextPacket;
-(BOOL)open:(NSString *)fileName;
-(void)close;

@end
