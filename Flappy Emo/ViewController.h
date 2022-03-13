//
//  ViewController.h
//  Flappy Emo
//
//  Created by Rayan on 9/12/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <iAd/iAd.h>

NSInteger HighScoreNumber;

@interface ViewController : UIViewController <ADBannerViewDelegate>

{
    IBOutlet UILabel *HighScore;
    AVAudioPlayer *ButtonSound;
    
    IBOutlet UIButton *PlayGame;
    IBOutlet UIButton *Info;
    
}

-(IBAction)StartSoundButton:(id)sender;

@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;


@end
