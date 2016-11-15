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

@property (nonatomic,strong) NSArray<NSString*>* rtmpUrl;

@property (nonatomic,strong) UIActivityIndicatorView* indicator;

@end

@implementation TEVideoPlayer
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (void)layoutSubviews
{
    self.indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
}

#pragma mark - *** Properties ***
- (RTMPGuestKit*)guestKit
{
    if (!_guestKit) {
        _guestKit = [[RTMPGuestKit alloc] initWithDelegate:self];
    }
    return _guestKit;
}

- (NSArray<NSString*>*) rtmpUrl{
    if (!_rtmpUrl) {
        _rtmpUrl = @[@"rtmp://live.hkstv.hk.lxdns.com/live/hks",@"rtmp://203.207.99.19:1935/live/zgjyt",@"rtmp://203.207.99.19:1935/live/CCTV5"];
    }
    return _rtmpUrl;
}

- (UIActivityIndicatorView*)indicator
{
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //_indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height);
    }
    return _indicator;
}

#pragma mark - *** Helper ***
- (void)setup
{
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self addGestureRecognizer:recognizer];
}

#pragma mark - *** Api ***
- (void)startRtmpPlayWithUrl:(NSString *)url
{
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
    if (self.indicator.superview) {
        [self.indicator stopAnimating];
        [self.indicator removeFromSuperview];
    }
    
}
- (void)OnRtmplayerCache:(int) time {
    NSLog(@"OnRtmplayerCache:%d",time);
    //self.stateRTMPLabel.text = [NSString stringWithFormat:@"RTMP正在缓存:%d",time];
    [self addSubview:self.indicator];
    [self.indicator startAnimating];
}

- (void)OnRtmplayerClosed:(int) errcode {
     NSLog(@"🌺🌺🌺🌺🌺🌺🌺OnRtmplayerClosed");
    NSString* url = self.rtmpUrl[arc4random() % self.rtmpUrl.count];
    [self startRtmpPlayWithUrl:url];
}

#pragma mark - ***Gesture Action ***

- (void)didPan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:self.superview];
    self.center = CGPointMake(self.center.x + point.x, self.center.y);
    [recognizer setTranslation:CGPointZero inView:self.superview];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.superview];
        velocity.y = 0;
        [self startAnimatingWithInitialVelocity:velocity];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged){
        //CGPoint velocity = [recognizer velocityInView:self.superview];
    }
    else if (recognizer.state == UIGestureRecognizerStateBegan) {
    }
}



- (void)startAnimatingWithInitialVelocity:(CGPoint)initialVelocity
{
    CGPoint targetPoint = CGPointZero;
    CGSize size = self.bounds.size;
    
    BOOL next = YES;
    
    if (initialVelocity.x >=100) {
        targetPoint = CGPointMake(size.width/2  + size.width, self.center.y);
    }
    else if(initialVelocity.x <= -100){
        targetPoint = CGPointMake(size.width/2 - size.width , self.center.y);
    }
    else{
        targetPoint = CGPointMake(size.width / 2, self.center.y);
        next = NO;
    }
    
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:4.0
                        options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.center = targetPoint;
                     }
                     completion:^(BOOL finished) {
                         if(next){
                             [self stopRtmpPlay];
                             //[self.guestKit clear];
                             //self.guestKit = nil;
                             CGSize size = self.bounds.size;
                             self.center = CGPointMake(size.width / 2, size.height / 2);
                         }
                     }
     ];
    
}
@end
