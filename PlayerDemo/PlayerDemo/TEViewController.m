//
//  ViewController.m
//  PlayerDemo
//
//  Created by zhangguang on 16/11/11.
//  Copyright © 2016年 com.V2.Telescope. All rights reserved.
//

#import "TEViewController.h"

#import <AVFoundation/AVFoundation.h>

#import "TEVideoPlayer.h"

@interface TEViewController ()
@property (weak, nonatomic) IBOutlet TEVideoPlayer *videoPlayer;
@end

@implementation TEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self.videoPlayer addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    [self.videoPlayer startRtmpPlayWithUrl:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
}

- (IBAction)closeBtnClicked:(id)sender {
    [self.videoPlayer clear];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    
    
}

@end
