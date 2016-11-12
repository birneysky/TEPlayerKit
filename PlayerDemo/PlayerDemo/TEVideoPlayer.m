//
//  TEVideoPlayer.m
//  PlayerDemo
//
//  Created by birneysky on 16/11/12.
//  Copyright © 2016年 com.V2.Telescope. All rights reserved.
//

#import "TEVideoPlayer.h"
#import <TEPlayerKit/TEPlayerKit.h>

@interface TEVideoPlayer ()<RTMPGuestRtmpDelegate>

@property (nonatomic, strong) RTMPGuestKit *guestKit;

@end

@implementation TEVideoPlayer

#pragma mark - *** Properties ***
- (RTMPGuestKit*)guestKit
{
    if (!_guestKit) {
        _guestKit = [[RTMPGuestKit alloc] initWithDelegate:self];
    }
    return _guestKit;
}

#pragma mark - *** Api ***
- (void)startRtmpPlayWithUrl:(NSString *)url
{
    NSLog(@"layoutBefore TEVideoPlayer bounds %@, frame %@",NSStringFromCGRect(self.bounds),NSStringFromCGRect(self.frame));
   // [self layoutIfNeeded];
    NSLog(@"layoutAfter TEVideoPlayer bounds %@, frame %@",NSStringFromCGRect(self.bounds),NSStringFromCGRect(self.frame));
    [self.guestKit StartRtmpPlay:url andRender:self];
}

- (void)stopRtmpPlay
{
    [self.guestKit StopRtmpPlay];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
