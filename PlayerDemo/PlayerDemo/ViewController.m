//
//  ViewController.m
//  PlayerDemo
//
//  Created by zhangguang on 16/11/11.
//  Copyright © 2016年 com.V2.Telescope. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "TEVideoPlayer.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TEVideoPlayer *videoPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.videoPlayer addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self.videoPlayer startRtmpPlayWithUrl:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}


@end
