//
//  YJExample.h
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/8.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YJExampleBlock)(void);

@interface YJExample : NSObject
@property (nonatomic,   copy) NSString *title;
@property (nonatomic,   copy) YJExampleBlock block;
+ (instancetype)exampleWithTitle:(NSString *)title block:(YJExampleBlock)block;
@end
