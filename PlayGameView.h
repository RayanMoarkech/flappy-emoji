//
//  PlayGameView.h
//  Flappy Emo
//
//  Created by Rayan on 11/8/14.
//  Copyright (c) 2014 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <iAd/iAd.h>

NSInteger HighScoreNumberNormal;
NSInteger HighScoreNumberArcade;

@interface PlayGameView : UIViewController <ADBannerViewDelegate>

{
    
    AVAudioPlayer *ButtonSound;
    
    IBOutlet UIButton *NormalMode;
    IBOutlet UIButton *ArcadeMode;
    IBOutlet UILabel *HighScoreNormal;
    IBOutlet UILabel *HighScoreArcade;
    
    ADBannerView *GameADs;
    
}

-(IBAction)SoundButton:(id)sender;

@property (weak, nonatomic) IBOutlet ADBannerView *adBanner;

@end
