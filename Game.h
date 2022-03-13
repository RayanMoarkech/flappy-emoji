//
//  Game.h
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>

int BirdFlight;
int BirdFall;
int RandomTopTunnelPosition;
int RandomBottomTunnelPosition;
int ScoreNumber;
NSInteger HighScoreNumber;
NSInteger HighScoreNumberNormal;

@interface Game : UIViewController

{
    
    IBOutlet UIImageView *Bird;
    IBOutlet UIImageView *DeadBird;
    IBOutlet UIButton *StartGame;
    IBOutlet UIButton *Retry;
    IBOutlet UIImageView *TunnelTop;
    IBOutlet UIImageView *TunnelBottom;
    IBOutlet UIImageView *Top;
    IBOutlet UIImageView *Bottom;
    IBOutlet UIButton *Exit;
    IBOutlet UIButton *Back;
    IBOutlet UILabel *ScoreLabel;
    IBOutlet UILabel *GameOver;
    IBOutlet UILabel *Nice;
    IBOutlet UILabel *GoodJob;
    IBOutlet UILabel *Great;
    IBOutlet UILabel *Excellent;
    IBOutlet UILabel *ZeroScore;
    IBOutlet ADBannerView *GameAD;
    
    AVAudioPlayer *ButtonSound;
    AVAudioPlayer *WinScore;
    AVAudioPlayer *StartGameButton;
    AVAudioPlayer *LostSound;
    
    NSTimer *BirdMovement;
    NSTimer *TunnelMovement;
    NSTimer *BirdMovFalling;
    NSTimer *GameOverTime;
}

-(IBAction)StartGame:(id)sender;
-(IBAction)Retry:(id)sender;
-(IBAction)SoundButton:(id)sender;
-(void)BirdMoving;
-(void)TunnelMoving;
-(void)TunnelMoving1;
-(void)PlaceTunnels;
-(void)Falling;
-(void)FallingFast;
-(void)BirdFalling;
-(void)BirdFallingFromTop;
-(void)Score;
-(void)GameOver;

@end
