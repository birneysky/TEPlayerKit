//
//  TEVideoPlayer.h
//  PlayerDemo
//
//  Created by birneysky on 16/11/12.
//  Copyright © 2016年 com.V2.Telescope. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 rtmp 播放器
 */
@interface TEVideoPlayer : UIView


/**
 开始播放

 @param url rtmp 播放地址
 */
- (void)startRtmpPlayWithUrl:(NSString*)url;



/**
 停止播放
 */
- (void)stopRtmpPlay;

@end
