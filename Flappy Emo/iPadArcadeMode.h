//
//  iPadArcadeMode.h
//  Flappy Emo
//
//  Created by Rayan on 11/22/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <iAd/iAd.h>

int BirdFlight;
int BirdFall;
int RandomTopTunnelPosition;
int RandomBottomTunnelPosition;
int ScoreNumber;
NSInteger HighScoreNumber;
NSInteger HighScoreNumberArcade;

@interface iPadArcadeMode : UIViewController <ADBannerViewDelegate>

{
    
    IBOutlet UIImageView *Bird;
    IBOutlet UIImageView *DeadBird;
    IBOutlet UIButton *StartGame;
    IBOutlet UIButton *Back;
    IBOutlet UIImageView *TunnelTop;
    IBOutlet UIImageView *TunnelBottom;
    IBOutlet UIImageView *Top;
    IBOutlet UIImageView *Bottom;
    IBOutlet UIImageView *Live1;
    IBOutlet UIImageView *Live2;
    IBOutlet UIImageView *Live3;
    IBOutlet UIButton *Exit;
    IBOutlet UILabel *ScoreLabel;
    IBOutlet UILabel *GameOver;
    IBOutlet UILabel *ZeroScore;
    IBOutlet ADBannerView *GameAdBanner;
    
    AVAudioPlayer *ButtonSound;
    AVAudioPlayer *WinScore;
    AVAudioPlayer *StartGameButton;
    AVAudioPlayer *LostSound;
    
    NSTimer *BirdMovement;
    NSTimer *TunnelMovement;
    NSTimer *TunnelTouchmentof1;
    NSTimer *TunnelTouchmentof2;
    NSTimer *TunnelTouchmentof3;
    NSTimer *BottomTouchment;
    NSTimer *BirdMovFalling;
    NSTimer *GameOverTime;
    
}

-(IBAction)StartGame:(id)sender;
-(IBAction)SoundButton:(id)sender;
-(void)BirdMoving;
-(void)TunnelMovingof1;
-(void)TunnelMovingof2;
-(void)TunnelMovingof3;
-(void)TunnelFast;
-(void)TunnelTouchof1;
-(void)TunnelTouchof2;
-(void)TunnelTouchof3;
-(void)BottomTouch;
-(void)PlaceTunnels;
-(void)Falling;
-(void)FallingFast;
-(void)BirdFalling;
-(void)BirdFallingFromTop;
-(void)Score;
-(void)GameOver;


@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;

@end
