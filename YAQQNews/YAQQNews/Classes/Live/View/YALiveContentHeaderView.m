//
//  YALiveContentHeaderView.m
//  YAQQNews
//
//  Created by 陈亚伦 on 2017/5/9.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YALiveContentHeaderView.h"
#import <UIImageView+YYWebImage.h>
#import "YALiveContent.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface YALiveContentHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;


@property (nonatomic, strong) NSURL *playurl;
@property (nonatomic, retain) id <IJKMediaPlayback> player;
@property (nonatomic, weak) UIView *PlayerView;
@end
@implementation YALiveContentHeaderView

+ (instancetype)liveContentHeaderView {

    return [[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil].firstObject;
}

- (void)setHeadContent:(YALiveContent *)headContent {
    _headContent = headContent;


    // 标题
    self.titleLabel.text = headContent.title;
    
    // 图片
    [self.videoImageView yy_setImageWithURL:[NSURL URLWithString:headContent.videoImage] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
    // 在线人数
    self.personNumLabel.text = headContent.onlineNumber;
    
    // 播放url
    self.playurl = [NSURL URLWithString:headContent.playurl];
    
/*
    方式一:直接替换vid
    http://vv.video.qq.com/geturl?vid=a0023iwnef6&otype=xml&platform=1&ran=0.9652906153351068
 
 */
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    /*
    // 获取点赞/在线人数
    http://r.inews.qq.com/checkLiveInfo?appver=10.2.1_qqnews_5.3.4&id=ZLV2017050904840300
    
    
    1. http://vv.video.qq.com/getinfo?otype=xml&vid=a0023iwnef6 获取id
    
    2. http://vv.video.qq.com/getkey?format=10203&type=xml&vid=a0023iwnef6&filename=a0023iwnef6.p203.mp4
     
     */
    self.playurl = [NSURL URLWithString:@""];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.playurl withOptions:nil];;

    //直播视频view
    UIView *playerView = [_player view];
    
    
    // 设置尺寸
    playerView.frame = self.bounds;
    
    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.PlayerView = playerView;
    
    [self insertSubview:playerView belowSubview:self.playButton];

    
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
    [self installMovieNotificationObservers];
    
    
    if (![_player isPlaying]) {
        [_player prepareToPlay];
    }
    

}

    

- (IBAction)startWatch:(UIButton *)sender {
    
    if (![self.player isPlaying]) {
        [self.player play];
    } else{
        [self.player pause];
    }
}


 #pragma mark – Getters and Setters
//- (id <IJKMediaPlayback>)player {
//    if (!_player) {
//        
//    }
//    return _player;
//}
//

 #pragma mark – Private Methods

 - (void)loadStateDidChange:(NSNotification*)notification {
 
     IJKMPMovieLoadState loadState = _player.loadState;
 
 if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
 
     NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
 }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
 
     NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
 } else {
 
     NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
 }
 }
 
 - (void)moviePlayBackFinish:(NSNotification*)notification {
 int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
 
     switch (reason) {
         case IJKMPMovieFinishReasonPlaybackEnded:
             NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
             break;
 
 
         case IJKMPMovieFinishReasonUserExited:
             NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
             break;
 
 
         case IJKMPMovieFinishReasonPlaybackError:
 
             NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
             break;
 

         default:
             NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
             break;
 }
 }
 
 - (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
 
     NSLog(@"mediaIsPrepareToPlayDidChange\n");
 }
 
 - (void)moviePlayBackStateDidChange:(NSNotification*)notification {
     switch (_player.playbackState) {
     case IJKMPMoviePlaybackStateStopped:
     NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
     break;
     
     case IJKMPMoviePlaybackStatePlaying:
     NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
     break;
     
     case IJKMPMoviePlaybackStatePaused:
     NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
     break;
     
     case IJKMPMoviePlaybackStateInterrupted:
     NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
     break;
     
     case IJKMPMoviePlaybackStateSeekingForward:
     case IJKMPMoviePlaybackStateSeekingBackward: {
     NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
     break;
 }
 
 default: {
 NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
 break;
 }
 }
 }
 
 #pragma Install Notifiacation
 - (void)installMovieNotificationObservers {
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(loadStateDidChange:)
 name:IJKMPMoviePlayerLoadStateDidChangeNotification
 object:_player];
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(moviePlayBackFinish:)
 name:IJKMPMoviePlayerPlaybackDidFinishNotification
 object:_player];
 
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(mediaIsPreparedToPlayDidChange:)
 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
 object:_player];
 
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(moviePlayBackStateDidChange:)
 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
 object:_player];
 
 }
 - (void)removeMovieNotificationObservers {
 [[NSNotificationCenter defaultCenter] removeObserver:self
 name:IJKMPMoviePlayerLoadStateDidChangeNotification
 object:_player];
 [[NSNotificationCenter defaultCenter] removeObserver:self
 name:IJKMPMoviePlayerPlaybackDidFinishNotification
 object:_player];
 [[NSNotificationCenter defaultCenter] removeObserver:self
 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
 object:_player];
 [[NSNotificationCenter defaultCenter] removeObserver:self
 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
 object:_player];
 
 }



@end
