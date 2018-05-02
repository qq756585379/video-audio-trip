//
//  PlayAAC.m
//  video-audio-trip
//
//  Created by 杨俊 on 2018/4/20.
//  Copyright © 2018年 qq756585379. All rights reserved.
//

#import "PlayAACViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PlayAACViewController ()
@property (nonatomic , strong) UIButton *mButton;
@end

@implementation PlayAACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    [button setTitle:@"play" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    self.mButton = button;
}

- (void)onClick:(UIButton *)button {
    [self.mButton setHidden:YES];
    NSURL *audioURL=[[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"aac"];
    SystemSoundID soundID;
    //Creates a system sound object.
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(audioURL), &soundID);
    //Registers a callback function that is invoked when a specified system sound finishes playing.
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, &playCallback, (__bridge void * _Nullable)(self));
    //    AudioServicesPlayAlertSound(soundID);
    AudioServicesPlaySystemSound(soundID);
}

void playCallback(SystemSoundID ID, void  * clientData){
    PlayAACViewController *controller = (__bridge PlayAACViewController *)clientData;
    [controller onPlayCallback];
}

- (void)onPlayCallback {
    [self.mButton setHidden:NO];
}

@end
