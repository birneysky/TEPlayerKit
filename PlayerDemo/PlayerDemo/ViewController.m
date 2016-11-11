//
//  ViewController.m
//  PlayerDemo
//
//  Created by zhangguang on 16/11/11.
//  Copyright © 2016年 com.V2.Telescope. All rights reserved.
//

#import "ViewController.h"
#import <TEPlayerKit/TEPlayerKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<RTMPGuestRtmpDelegate>
@property (nonatomic, strong) RTMPGuestKit *guestKit;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AudioSessionInitialize(NULL,
                           kCFRunLoopCommonModes,
                           NULL,NULL);
    self.guestKit = [[RTMPGuestKit alloc] initWithDelegate:self];
    [self.guestKit StartRtmpPlay:@"rtmp://live.hkstv.hk.lxdns.com/live/hks" andRender:self.view];
//    if (self.urlStr) {
//
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - *** RTMPGuestRtmpDelegate ***
- (void)OnRtmplayerOK {
    NSLog(@"OnRtmpStreamOK");
    //self.stateRTMPLabel.text = @"连接RTMP服务成功";
}
- (void)OnRtmplayerStatus:(int) cacheTime withBitrate:(int) curBitrate {
    NSLog(@"OnRtmplayerStatus:%d withBitrate:%d",cacheTime,curBitrate);
    //self.stateRTMPLabel.text = [NSString stringWithFormat:@"RTMP缓存区:%d 码率:%d",cacheTime,curBitrate];
}
- (void)OnRtmplayerCache:(int) time {
    NSLog(@"OnRtmplayerCache:%d",time);
    //self.stateRTMPLabel.text = [NSString stringWithFormat:@"RTMP正在缓存:%d",time];
}

- (void)OnRtmplayerClosed:(int) errcode {
    
}

@end
