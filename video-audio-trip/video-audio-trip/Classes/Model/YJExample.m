//
//  YJExample.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "YJExample.h"

@implementation YJExample

+ (instancetype)exampleWithTitle:(NSString *)title block:(YJExampleBlock)block {
    YJExample *example = [[self class] new];
    example.title = title;
    example.block = block;
    return example;
}

@end
