//
//  DecodeAACViewController.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/20.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "DecodeAACViewController.h"
#import "AACPlayer.h"

@interface DecodeAACViewController ()
@property (nonatomic , strong) UILabel *mCurrentTimeLabel;
@property (nonatomic , strong) UIButton *mDecodeButton;
@property (nonatomic , strong) CADisplayLink *mDispalyLink;
@end

@implementation DecodeAACViewController
{
    AACPlayer *_player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mCurrentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 200, 100)];
    self.mCurrentTimeLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.mCurrentTimeLabel];
    
    self.mDecodeButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    [self.mDecodeButton setTitle:@"decode" forState:UIControlStateNormal];
    [self.mDecodeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.mDecodeButton];
    [self.mDecodeButton addTarget:self action:@selector(onDecodeStart) forControlEvents:UIControlEventTouchUpInside];
    
    self.mDispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame)];
    self.mDispalyLink.frameInterval = 5; // 默认是30FPS的帧率录制
    [self.mDispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.mDispalyLink setPaused:NO];
}

- (void)onDecodeStart {
    self.mDecodeButton.hidden = YES;
    _player = [[AACPlayer alloc] init];
    [_player play];
}

- (void)updateFrame {
    if (_player) {
        self.mCurrentTimeLabel.text = [NSString stringWithFormat:@"当前时间:%.1fs", [_player getCurrentTime]];
    }
}

@end
